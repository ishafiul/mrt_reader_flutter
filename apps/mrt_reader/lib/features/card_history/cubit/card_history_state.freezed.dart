// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
CardHistoryState _$CardHistoryStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'initial':
      return CardHistoryStateInitial.fromJson(json);
    case 'loading':
      return CardHistoryStateLoding.fromJson(json);
    case 'loaded':
      return CardHistoryStateLoaded.fromJson(json);
    case 'error':
      return CardHistoryStateError.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'CardHistoryState',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$CardHistoryState {
  /// Serializes this CardHistoryState to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CardHistoryState);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CardHistoryState()';
  }
}

/// @nodoc
class $CardHistoryStateCopyWith<$Res> {
  $CardHistoryStateCopyWith(
      CardHistoryState _, $Res Function(CardHistoryState) __);
}

/// @nodoc
@JsonSerializable()
class CardHistoryStateInitial extends CardHistoryState {
  const CardHistoryStateInitial({final String? $type})
      : $type = $type ?? 'initial',
        super._();
  factory CardHistoryStateInitial.fromJson(Map<String, dynamic> json) =>
      _$CardHistoryStateInitialFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  Map<String, dynamic> toJson() {
    return _$CardHistoryStateInitialToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CardHistoryStateInitial);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CardHistoryState.initial()';
  }
}

/// @nodoc
@JsonSerializable()
class CardHistoryStateLoding extends CardHistoryState {
  const CardHistoryStateLoding({final String? $type})
      : $type = $type ?? 'loading',
        super._();
  factory CardHistoryStateLoding.fromJson(Map<String, dynamic> json) =>
      _$CardHistoryStateLodingFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  Map<String, dynamic> toJson() {
    return _$CardHistoryStateLodingToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CardHistoryStateLoding);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CardHistoryState.loading()';
  }
}

/// @nodoc
@JsonSerializable()
class CardHistoryStateLoaded extends CardHistoryState {
  const CardHistoryStateLoaded(final List<CardData> cards,
      {final String? $type})
      : _cards = cards,
        $type = $type ?? 'loaded',
        super._();
  factory CardHistoryStateLoaded.fromJson(Map<String, dynamic> json) =>
      _$CardHistoryStateLoadedFromJson(json);

  final List<CardData> _cards;
  List<CardData> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of CardHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardHistoryStateLoadedCopyWith<CardHistoryStateLoaded> get copyWith =>
      _$CardHistoryStateLoadedCopyWithImpl<CardHistoryStateLoaded>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CardHistoryStateLoadedToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardHistoryStateLoaded &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cards));

  @override
  String toString() {
    return 'CardHistoryState.loaded(cards: $cards)';
  }
}

/// @nodoc
abstract mixin class $CardHistoryStateLoadedCopyWith<$Res>
    implements $CardHistoryStateCopyWith<$Res> {
  factory $CardHistoryStateLoadedCopyWith(CardHistoryStateLoaded value,
          $Res Function(CardHistoryStateLoaded) _then) =
      _$CardHistoryStateLoadedCopyWithImpl;
  @useResult
  $Res call({List<CardData> cards});
}

/// @nodoc
class _$CardHistoryStateLoadedCopyWithImpl<$Res>
    implements $CardHistoryStateLoadedCopyWith<$Res> {
  _$CardHistoryStateLoadedCopyWithImpl(this._self, this._then);

  final CardHistoryStateLoaded _self;
  final $Res Function(CardHistoryStateLoaded) _then;

  /// Create a copy of CardHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cards = null,
  }) {
    return _then(CardHistoryStateLoaded(
      null == cards
          ? _self._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<CardData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class CardHistoryStateError extends CardHistoryState {
  const CardHistoryStateError(this.message, {final String? $type})
      : $type = $type ?? 'error',
        super._();
  factory CardHistoryStateError.fromJson(Map<String, dynamic> json) =>
      _$CardHistoryStateErrorFromJson(json);

  final String message;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of CardHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardHistoryStateErrorCopyWith<CardHistoryStateError> get copyWith =>
      _$CardHistoryStateErrorCopyWithImpl<CardHistoryStateError>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CardHistoryStateErrorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardHistoryStateError &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'CardHistoryState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $CardHistoryStateErrorCopyWith<$Res>
    implements $CardHistoryStateCopyWith<$Res> {
  factory $CardHistoryStateErrorCopyWith(CardHistoryStateError value,
          $Res Function(CardHistoryStateError) _then) =
      _$CardHistoryStateErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$CardHistoryStateErrorCopyWithImpl<$Res>
    implements $CardHistoryStateErrorCopyWith<$Res> {
  _$CardHistoryStateErrorCopyWithImpl(this._self, this._then);

  final CardHistoryStateError _self;
  final $Res Function(CardHistoryStateError) _then;

  /// Create a copy of CardHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(CardHistoryStateError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
