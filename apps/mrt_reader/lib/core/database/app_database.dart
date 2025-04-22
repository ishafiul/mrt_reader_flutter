import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:mrt_card_reader/mrt_card_reader.dart';
import 'package:mrt_reader/core/models/card_data.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class CardEntities extends Table {
  TextColumn get cardId => text().withLength(min: 1, max: 50)();
  IntColumn get balance => integer()();
  IntColumn get lastScannedTimestamp => integer()();
  TextColumn get transactionsJson => text()();

  @override
  Set<Column> get primaryKey => {cardId};
}

@DriftDatabase(tables: [CardEntities])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Convert CardData to CardCompanion
  CardEntitiesCompanion _cardDataToCompanion(CardData card) {
    return CardEntitiesCompanion(
      cardId: Value(card.cardId),
      balance: Value(card.balance),
      lastScannedTimestamp: Value(card.lastScanned.millisecondsSinceEpoch),
      transactionsJson: Value(
        jsonEncode(card.transactions.map((t) => t.toMap()).toList()),
      ),
    );
  }

  // Convert CardEntity to CardData
  CardData _entityToCardData(CardEntity entity) {
    var transactionsList = <dynamic>[];
    try {
      transactionsList = jsonDecode(entity.transactionsJson) as List<dynamic>;
    } catch (_) {
      // If decoding fails, use an empty list
    }

    return CardData(
      cardId: entity.cardId,
      balance: entity.balance,
      lastScanned:
          DateTime.fromMillisecondsSinceEpoch(entity.lastScannedTimestamp),
      transactions: transactionsList
          .map((json) => MrtTransaction.fromMap(json as Map<String, dynamic>))
          .toList(),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'mrt_reader.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@singleton
class DatabaseService {
  @factoryMethod
  DatabaseService() : _database = AppDatabase();
  final AppDatabase _database;

  // Save card data
  Future<void> saveCardData(CardData cardData) async {
    await _database.into(_database.cardEntities).insert(
          _database._cardDataToCompanion(cardData),
          mode: InsertMode.insertOrReplace,
        );
  }

  // Get all cards
  Future<List<CardData>> getAllCards() async {
    final entities = await _database.select(_database.cardEntities).get();
    return entities.map(_database._entityToCardData).toList();
  }

  // Get card by ID
  Future<CardData?> getCardById(String cardId) async {
    final query = _database.select(_database.cardEntities)
      ..where((tbl) => tbl.cardId.equals(cardId));

    final entity = await query.getSingleOrNull();
    if (entity == null) return null;

    return _database._entityToCardData(entity);
  }

  // Delete card
  Future<void> deleteCard(String cardId) async {
    final query = _database.delete(_database.cardEntities)
      ..where((tbl) => tbl.cardId.equals(cardId));

    await query.go();
  }
}
