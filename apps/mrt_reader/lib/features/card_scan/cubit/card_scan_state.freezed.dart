// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_scan_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CardScanState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CardScanState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CardScanState()';
  }
}

/// @nodoc
class $CardScanStateCopyWith<$Res> {
  $CardScanStateCopyWith(CardScanState _, $Res Function(CardScanState) __);
}

/// @nodoc

class CardScanStateInitial extends CardScanState {
  const CardScanStateInitial() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CardScanStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CardScanState.initial()';
  }
}

/// @nodoc

class CardScanStateWaiting extends CardScanState {
  const CardScanStateWaiting() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CardScanStateWaiting);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CardScanState.waiting()';
  }
}

/// @nodoc

class CardScanStateReading extends CardScanState {
  const CardScanStateReading() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CardScanStateReading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CardScanState.reading()';
  }
}

/// @nodoc

class CardScanStateSuccess extends CardScanState {
  const CardScanStateSuccess(
      {required this.cardId,
      required this.balance,
      required final List<MrtTransaction> transactions})
      : _transactions = transactions,
        super._();

  final String cardId;
  final int balance;
  final List<MrtTransaction> _transactions;
  List<MrtTransaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  /// Create a copy of CardScanState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardScanStateSuccessCopyWith<CardScanStateSuccess> get copyWith =>
      _$CardScanStateSuccessCopyWithImpl<CardScanStateSuccess>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardScanStateSuccess &&
            (identical(other.cardId, cardId) || other.cardId == cardId) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cardId, balance,
      const DeepCollectionEquality().hash(_transactions));

  @override
  String toString() {
    return 'CardScanState.success(cardId: $cardId, balance: $balance, transactions: $transactions)';
  }
}

/// @nodoc
abstract mixin class $CardScanStateSuccessCopyWith<$Res>
    implements $CardScanStateCopyWith<$Res> {
  factory $CardScanStateSuccessCopyWith(CardScanStateSuccess value,
          $Res Function(CardScanStateSuccess) _then) =
      _$CardScanStateSuccessCopyWithImpl;
  @useResult
  $Res call({String cardId, int balance, List<MrtTransaction> transactions});
}

/// @nodoc
class _$CardScanStateSuccessCopyWithImpl<$Res>
    implements $CardScanStateSuccessCopyWith<$Res> {
  _$CardScanStateSuccessCopyWithImpl(this._self, this._then);

  final CardScanStateSuccess _self;
  final $Res Function(CardScanStateSuccess) _then;

  /// Create a copy of CardScanState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cardId = null,
    Object? balance = null,
    Object? transactions = null,
  }) {
    return _then(CardScanStateSuccess(
      cardId: null == cardId
          ? _self.cardId
          : cardId // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
      transactions: null == transactions
          ? _self._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<MrtTransaction>,
    ));
  }
}

/// @nodoc

class CardScanStateError extends CardScanState {
  const CardScanStateError(this.message) : super._();

  final String message;

  /// Create a copy of CardScanState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardScanStateErrorCopyWith<CardScanStateError> get copyWith =>
      _$CardScanStateErrorCopyWithImpl<CardScanStateError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardScanStateError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'CardScanState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $CardScanStateErrorCopyWith<$Res>
    implements $CardScanStateCopyWith<$Res> {
  factory $CardScanStateErrorCopyWith(
          CardScanStateError value, $Res Function(CardScanStateError) _then) =
      _$CardScanStateErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$CardScanStateErrorCopyWithImpl<$Res>
    implements $CardScanStateErrorCopyWith<$Res> {
  _$CardScanStateErrorCopyWithImpl(this._self, this._then);

  final CardScanStateError _self;
  final $Res Function(CardScanStateError) _then;

  /// Create a copy of CardScanState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(CardScanStateError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
