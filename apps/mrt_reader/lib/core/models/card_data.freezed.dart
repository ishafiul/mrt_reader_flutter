// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CardData {
  String get cardId;
  int get balance;
  DateTime get lastScanned;
  @MrtTransactionConverter()
  List<MrtTransaction> get transactions;

  /// Create a copy of CardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardDataCopyWith<CardData> get copyWith =>
      _$CardDataCopyWithImpl<CardData>(this as CardData, _$identity);

  /// Serializes this CardData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardData &&
            (identical(other.cardId, cardId) || other.cardId == cardId) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.lastScanned, lastScanned) ||
                other.lastScanned == lastScanned) &&
            const DeepCollectionEquality()
                .equals(other.transactions, transactions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, cardId, balance, lastScanned,
      const DeepCollectionEquality().hash(transactions));

  @override
  String toString() {
    return 'CardData(cardId: $cardId, balance: $balance, lastScanned: $lastScanned, transactions: $transactions)';
  }
}

/// @nodoc
abstract mixin class $CardDataCopyWith<$Res> {
  factory $CardDataCopyWith(CardData value, $Res Function(CardData) _then) =
      _$CardDataCopyWithImpl;
  @useResult
  $Res call(
      {String cardId,
      int balance,
      DateTime lastScanned,
      @MrtTransactionConverter() List<MrtTransaction> transactions});
}

/// @nodoc
class _$CardDataCopyWithImpl<$Res> implements $CardDataCopyWith<$Res> {
  _$CardDataCopyWithImpl(this._self, this._then);

  final CardData _self;
  final $Res Function(CardData) _then;

  /// Create a copy of CardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardId = null,
    Object? balance = null,
    Object? lastScanned = null,
    Object? transactions = null,
  }) {
    return _then(_self.copyWith(
      cardId: null == cardId
          ? _self.cardId
          : cardId // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
      lastScanned: null == lastScanned
          ? _self.lastScanned
          : lastScanned // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactions: null == transactions
          ? _self.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<MrtTransaction>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CardData implements CardData {
  const _CardData(
      {required this.cardId,
      required this.balance,
      required this.lastScanned,
      @MrtTransactionConverter()
      required final List<MrtTransaction> transactions})
      : _transactions = transactions;
  factory _CardData.fromJson(Map<String, dynamic> json) =>
      _$CardDataFromJson(json);

  @override
  final String cardId;
  @override
  final int balance;
  @override
  final DateTime lastScanned;
  final List<MrtTransaction> _transactions;
  @override
  @MrtTransactionConverter()
  List<MrtTransaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  /// Create a copy of CardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CardDataCopyWith<_CardData> get copyWith =>
      __$CardDataCopyWithImpl<_CardData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CardDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CardData &&
            (identical(other.cardId, cardId) || other.cardId == cardId) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.lastScanned, lastScanned) ||
                other.lastScanned == lastScanned) &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, cardId, balance, lastScanned,
      const DeepCollectionEquality().hash(_transactions));

  @override
  String toString() {
    return 'CardData(cardId: $cardId, balance: $balance, lastScanned: $lastScanned, transactions: $transactions)';
  }
}

/// @nodoc
abstract mixin class _$CardDataCopyWith<$Res>
    implements $CardDataCopyWith<$Res> {
  factory _$CardDataCopyWith(_CardData value, $Res Function(_CardData) _then) =
      __$CardDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String cardId,
      int balance,
      DateTime lastScanned,
      @MrtTransactionConverter() List<MrtTransaction> transactions});
}

/// @nodoc
class __$CardDataCopyWithImpl<$Res> implements _$CardDataCopyWith<$Res> {
  __$CardDataCopyWithImpl(this._self, this._then);

  final _CardData _self;
  final $Res Function(_CardData) _then;

  /// Create a copy of CardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cardId = null,
    Object? balance = null,
    Object? lastScanned = null,
    Object? transactions = null,
  }) {
    return _then(_CardData(
      cardId: null == cardId
          ? _self.cardId
          : cardId // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
      lastScanned: null == lastScanned
          ? _self.lastScanned
          : lastScanned // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactions: null == transactions
          ? _self._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<MrtTransaction>,
    ));
  }
}

// dart format on
