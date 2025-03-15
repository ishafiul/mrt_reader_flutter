// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CardEntitiesTable extends CardEntities
    with TableInfo<$CardEntitiesTable, CardEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
      'card_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _balanceMeta =
      const VerificationMeta('balance');
  @override
  late final GeneratedColumn<int> balance = GeneratedColumn<int>(
      'balance', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastScannedTimestampMeta =
      const VerificationMeta('lastScannedTimestamp');
  @override
  late final GeneratedColumn<int> lastScannedTimestamp = GeneratedColumn<int>(
      'last_scanned_timestamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _transactionsJsonMeta =
      const VerificationMeta('transactionsJson');
  @override
  late final GeneratedColumn<String> transactionsJson = GeneratedColumn<String>(
      'transactions_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [cardId, balance, lastScannedTimestamp, transactionsJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_entities';
  @override
  VerificationContext validateIntegrity(Insertable<CardEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta,
          cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(_balanceMeta,
          balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta));
    } else if (isInserting) {
      context.missing(_balanceMeta);
    }
    if (data.containsKey('last_scanned_timestamp')) {
      context.handle(
          _lastScannedTimestampMeta,
          lastScannedTimestamp.isAcceptableOrUnknown(
              data['last_scanned_timestamp']!, _lastScannedTimestampMeta));
    } else if (isInserting) {
      context.missing(_lastScannedTimestampMeta);
    }
    if (data.containsKey('transactions_json')) {
      context.handle(
          _transactionsJsonMeta,
          transactionsJson.isAcceptableOrUnknown(
              data['transactions_json']!, _transactionsJsonMeta));
    } else if (isInserting) {
      context.missing(_transactionsJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cardId};
  @override
  CardEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardEntity(
      cardId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_id'])!,
      balance: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}balance'])!,
      lastScannedTimestamp: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}last_scanned_timestamp'])!,
      transactionsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transactions_json'])!,
    );
  }

  @override
  $CardEntitiesTable createAlias(String alias) {
    return $CardEntitiesTable(attachedDatabase, alias);
  }
}

class CardEntity extends DataClass implements Insertable<CardEntity> {
  final String cardId;
  final int balance;
  final int lastScannedTimestamp;
  final String transactionsJson;
  const CardEntity(
      {required this.cardId,
      required this.balance,
      required this.lastScannedTimestamp,
      required this.transactionsJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['card_id'] = Variable<String>(cardId);
    map['balance'] = Variable<int>(balance);
    map['last_scanned_timestamp'] = Variable<int>(lastScannedTimestamp);
    map['transactions_json'] = Variable<String>(transactionsJson);
    return map;
  }

  CardEntitiesCompanion toCompanion(bool nullToAbsent) {
    return CardEntitiesCompanion(
      cardId: Value(cardId),
      balance: Value(balance),
      lastScannedTimestamp: Value(lastScannedTimestamp),
      transactionsJson: Value(transactionsJson),
    );
  }

  factory CardEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardEntity(
      cardId: serializer.fromJson<String>(json['cardId']),
      balance: serializer.fromJson<int>(json['balance']),
      lastScannedTimestamp:
          serializer.fromJson<int>(json['lastScannedTimestamp']),
      transactionsJson: serializer.fromJson<String>(json['transactionsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cardId': serializer.toJson<String>(cardId),
      'balance': serializer.toJson<int>(balance),
      'lastScannedTimestamp': serializer.toJson<int>(lastScannedTimestamp),
      'transactionsJson': serializer.toJson<String>(transactionsJson),
    };
  }

  CardEntity copyWith(
          {String? cardId,
          int? balance,
          int? lastScannedTimestamp,
          String? transactionsJson}) =>
      CardEntity(
        cardId: cardId ?? this.cardId,
        balance: balance ?? this.balance,
        lastScannedTimestamp: lastScannedTimestamp ?? this.lastScannedTimestamp,
        transactionsJson: transactionsJson ?? this.transactionsJson,
      );
  CardEntity copyWithCompanion(CardEntitiesCompanion data) {
    return CardEntity(
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      balance: data.balance.present ? data.balance.value : this.balance,
      lastScannedTimestamp: data.lastScannedTimestamp.present
          ? data.lastScannedTimestamp.value
          : this.lastScannedTimestamp,
      transactionsJson: data.transactionsJson.present
          ? data.transactionsJson.value
          : this.transactionsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardEntity(')
          ..write('cardId: $cardId, ')
          ..write('balance: $balance, ')
          ..write('lastScannedTimestamp: $lastScannedTimestamp, ')
          ..write('transactionsJson: $transactionsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(cardId, balance, lastScannedTimestamp, transactionsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardEntity &&
          other.cardId == this.cardId &&
          other.balance == this.balance &&
          other.lastScannedTimestamp == this.lastScannedTimestamp &&
          other.transactionsJson == this.transactionsJson);
}

class CardEntitiesCompanion extends UpdateCompanion<CardEntity> {
  final Value<String> cardId;
  final Value<int> balance;
  final Value<int> lastScannedTimestamp;
  final Value<String> transactionsJson;
  final Value<int> rowid;
  const CardEntitiesCompanion({
    this.cardId = const Value.absent(),
    this.balance = const Value.absent(),
    this.lastScannedTimestamp = const Value.absent(),
    this.transactionsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CardEntitiesCompanion.insert({
    required String cardId,
    required int balance,
    required int lastScannedTimestamp,
    required String transactionsJson,
    this.rowid = const Value.absent(),
  })  : cardId = Value(cardId),
        balance = Value(balance),
        lastScannedTimestamp = Value(lastScannedTimestamp),
        transactionsJson = Value(transactionsJson);
  static Insertable<CardEntity> custom({
    Expression<String>? cardId,
    Expression<int>? balance,
    Expression<int>? lastScannedTimestamp,
    Expression<String>? transactionsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cardId != null) 'card_id': cardId,
      if (balance != null) 'balance': balance,
      if (lastScannedTimestamp != null)
        'last_scanned_timestamp': lastScannedTimestamp,
      if (transactionsJson != null) 'transactions_json': transactionsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CardEntitiesCompanion copyWith(
      {Value<String>? cardId,
      Value<int>? balance,
      Value<int>? lastScannedTimestamp,
      Value<String>? transactionsJson,
      Value<int>? rowid}) {
    return CardEntitiesCompanion(
      cardId: cardId ?? this.cardId,
      balance: balance ?? this.balance,
      lastScannedTimestamp: lastScannedTimestamp ?? this.lastScannedTimestamp,
      transactionsJson: transactionsJson ?? this.transactionsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (balance.present) {
      map['balance'] = Variable<int>(balance.value);
    }
    if (lastScannedTimestamp.present) {
      map['last_scanned_timestamp'] = Variable<int>(lastScannedTimestamp.value);
    }
    if (transactionsJson.present) {
      map['transactions_json'] = Variable<String>(transactionsJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardEntitiesCompanion(')
          ..write('cardId: $cardId, ')
          ..write('balance: $balance, ')
          ..write('lastScannedTimestamp: $lastScannedTimestamp, ')
          ..write('transactionsJson: $transactionsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CardEntitiesTable cardEntities = $CardEntitiesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cardEntities];
}

typedef $$CardEntitiesTableCreateCompanionBuilder = CardEntitiesCompanion
    Function({
  required String cardId,
  required int balance,
  required int lastScannedTimestamp,
  required String transactionsJson,
  Value<int> rowid,
});
typedef $$CardEntitiesTableUpdateCompanionBuilder = CardEntitiesCompanion
    Function({
  Value<String> cardId,
  Value<int> balance,
  Value<int> lastScannedTimestamp,
  Value<String> transactionsJson,
  Value<int> rowid,
});

class $$CardEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $CardEntitiesTable> {
  $$CardEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get cardId => $composableBuilder(
      column: $table.cardId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get balance => $composableBuilder(
      column: $table.balance, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastScannedTimestamp => $composableBuilder(
      column: $table.lastScannedTimestamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transactionsJson => $composableBuilder(
      column: $table.transactionsJson,
      builder: (column) => ColumnFilters(column));
}

class $$CardEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $CardEntitiesTable> {
  $$CardEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cardId => $composableBuilder(
      column: $table.cardId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get balance => $composableBuilder(
      column: $table.balance, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastScannedTimestamp => $composableBuilder(
      column: $table.lastScannedTimestamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transactionsJson => $composableBuilder(
      column: $table.transactionsJson,
      builder: (column) => ColumnOrderings(column));
}

class $$CardEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardEntitiesTable> {
  $$CardEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get cardId =>
      $composableBuilder(column: $table.cardId, builder: (column) => column);

  GeneratedColumn<int> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<int> get lastScannedTimestamp => $composableBuilder(
      column: $table.lastScannedTimestamp, builder: (column) => column);

  GeneratedColumn<String> get transactionsJson => $composableBuilder(
      column: $table.transactionsJson, builder: (column) => column);
}

class $$CardEntitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CardEntitiesTable,
    CardEntity,
    $$CardEntitiesTableFilterComposer,
    $$CardEntitiesTableOrderingComposer,
    $$CardEntitiesTableAnnotationComposer,
    $$CardEntitiesTableCreateCompanionBuilder,
    $$CardEntitiesTableUpdateCompanionBuilder,
    (CardEntity, BaseReferences<_$AppDatabase, $CardEntitiesTable, CardEntity>),
    CardEntity,
    PrefetchHooks Function()> {
  $$CardEntitiesTableTableManager(_$AppDatabase db, $CardEntitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardEntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardEntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardEntitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> cardId = const Value.absent(),
            Value<int> balance = const Value.absent(),
            Value<int> lastScannedTimestamp = const Value.absent(),
            Value<String> transactionsJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CardEntitiesCompanion(
            cardId: cardId,
            balance: balance,
            lastScannedTimestamp: lastScannedTimestamp,
            transactionsJson: transactionsJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String cardId,
            required int balance,
            required int lastScannedTimestamp,
            required String transactionsJson,
            Value<int> rowid = const Value.absent(),
          }) =>
              CardEntitiesCompanion.insert(
            cardId: cardId,
            balance: balance,
            lastScannedTimestamp: lastScannedTimestamp,
            transactionsJson: transactionsJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CardEntitiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CardEntitiesTable,
    CardEntity,
    $$CardEntitiesTableFilterComposer,
    $$CardEntitiesTableOrderingComposer,
    $$CardEntitiesTableAnnotationComposer,
    $$CardEntitiesTableCreateCompanionBuilder,
    $$CardEntitiesTableUpdateCompanionBuilder,
    (CardEntity, BaseReferences<_$AppDatabase, $CardEntitiesTable, CardEntity>),
    CardEntity,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CardEntitiesTableTableManager get cardEntities =>
      $$CardEntitiesTableTableManager(_db, _db.cardEntities);
}
