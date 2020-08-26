// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of paged_call_state;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$PagedCallStateTearOff {
  const _$PagedCallStateTearOff();

// ignore: unused_element
  InitialProgress<T> initialProgress<T>() {
    return InitialProgress<T>();
  }

// ignore: unused_element
  InitialSuccess<T> initialSuccess<T>(T result) {
    return InitialSuccess<T>(
      result,
    );
  }

// ignore: unused_element
  InitialError<T> initialError<T>(RKString errorMessage) {
    return InitialError<T>(
      errorMessage,
    );
  }

// ignore: unused_element
  AdditionalProgress<T> additionalProgress<T>() {
    return AdditionalProgress<T>();
  }

// ignore: unused_element
  AdditionalSuccess<T> additionalSuccess<T>(T result) {
    return AdditionalSuccess<T>(
      result,
    );
  }

// ignore: unused_element
  AdditionalError<T> additionalError<T>(RKString errorMessage) {
    return AdditionalError<T>(
      errorMessage,
    );
  }
}

// ignore: unused_element
const $PagedCallState = _$PagedCallStateTearOff();

mixin _$PagedCallState<T> {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initialProgress(),
    @required Result initialSuccess(T result),
    @required Result initialError(RKString errorMessage),
    @required Result additionalProgress(),
    @required Result additionalSuccess(T result),
    @required Result additionalError(RKString errorMessage),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initialProgress(),
    Result initialSuccess(T result),
    Result initialError(RKString errorMessage),
    Result additionalProgress(),
    Result additionalSuccess(T result),
    Result additionalError(RKString errorMessage),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initialProgress(InitialProgress<T> value),
    @required Result initialSuccess(InitialSuccess<T> value),
    @required Result initialError(InitialError<T> value),
    @required Result additionalProgress(AdditionalProgress<T> value),
    @required Result additionalSuccess(AdditionalSuccess<T> value),
    @required Result additionalError(AdditionalError<T> value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initialProgress(InitialProgress<T> value),
    Result initialSuccess(InitialSuccess<T> value),
    Result initialError(InitialError<T> value),
    Result additionalProgress(AdditionalProgress<T> value),
    Result additionalSuccess(AdditionalSuccess<T> value),
    Result additionalError(AdditionalError<T> value),
    @required Result orElse(),
  });
}

abstract class $PagedCallStateCopyWith<T, $Res> {
  factory $PagedCallStateCopyWith(
          PagedCallState<T> value, $Res Function(PagedCallState<T>) then) =
      _$PagedCallStateCopyWithImpl<T, $Res>;
}

class _$PagedCallStateCopyWithImpl<T, $Res>
    implements $PagedCallStateCopyWith<T, $Res> {
  _$PagedCallStateCopyWithImpl(this._value, this._then);

  final PagedCallState<T> _value;
  // ignore: unused_field
  final $Res Function(PagedCallState<T>) _then;
}

abstract class $InitialProgressCopyWith<T, $Res> {
  factory $InitialProgressCopyWith(
          InitialProgress<T> value, $Res Function(InitialProgress<T>) then) =
      _$InitialProgressCopyWithImpl<T, $Res>;
}

class _$InitialProgressCopyWithImpl<T, $Res>
    extends _$PagedCallStateCopyWithImpl<T, $Res>
    implements $InitialProgressCopyWith<T, $Res> {
  _$InitialProgressCopyWithImpl(
      InitialProgress<T> _value, $Res Function(InitialProgress<T>) _then)
      : super(_value, (v) => _then(v as InitialProgress<T>));

  @override
  InitialProgress<T> get _value => super._value as InitialProgress<T>;
}

class _$InitialProgress<T> implements InitialProgress<T> {
  const _$InitialProgress();

  @override
  String toString() {
    return 'PagedCallState<$T>.initialProgress()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is InitialProgress<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initialProgress(),
    @required Result initialSuccess(T result),
    @required Result initialError(RKString errorMessage),
    @required Result additionalProgress(),
    @required Result additionalSuccess(T result),
    @required Result additionalError(RKString errorMessage),
  }) {
    assert(initialProgress != null);
    assert(initialSuccess != null);
    assert(initialError != null);
    assert(additionalProgress != null);
    assert(additionalSuccess != null);
    assert(additionalError != null);
    return initialProgress();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initialProgress(),
    Result initialSuccess(T result),
    Result initialError(RKString errorMessage),
    Result additionalProgress(),
    Result additionalSuccess(T result),
    Result additionalError(RKString errorMessage),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initialProgress != null) {
      return initialProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initialProgress(InitialProgress<T> value),
    @required Result initialSuccess(InitialSuccess<T> value),
    @required Result initialError(InitialError<T> value),
    @required Result additionalProgress(AdditionalProgress<T> value),
    @required Result additionalSuccess(AdditionalSuccess<T> value),
    @required Result additionalError(AdditionalError<T> value),
  }) {
    assert(initialProgress != null);
    assert(initialSuccess != null);
    assert(initialError != null);
    assert(additionalProgress != null);
    assert(additionalSuccess != null);
    assert(additionalError != null);
    return initialProgress(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initialProgress(InitialProgress<T> value),
    Result initialSuccess(InitialSuccess<T> value),
    Result initialError(InitialError<T> value),
    Result additionalProgress(AdditionalProgress<T> value),
    Result additionalSuccess(AdditionalSuccess<T> value),
    Result additionalError(AdditionalError<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initialProgress != null) {
      return initialProgress(this);
    }
    return orElse();
  }
}

abstract class InitialProgress<T> implements PagedCallState<T> {
  const factory InitialProgress() = _$InitialProgress<T>;
}

abstract class $InitialSuccessCopyWith<T, $Res> {
  factory $InitialSuccessCopyWith(
          InitialSuccess<T> value, $Res Function(InitialSuccess<T>) then) =
      _$InitialSuccessCopyWithImpl<T, $Res>;
  $Res call({T result});
}

class _$InitialSuccessCopyWithImpl<T, $Res>
    extends _$PagedCallStateCopyWithImpl<T, $Res>
    implements $InitialSuccessCopyWith<T, $Res> {
  _$InitialSuccessCopyWithImpl(
      InitialSuccess<T> _value, $Res Function(InitialSuccess<T>) _then)
      : super(_value, (v) => _then(v as InitialSuccess<T>));

  @override
  InitialSuccess<T> get _value => super._value as InitialSuccess<T>;

  @override
  $Res call({
    Object result = freezed,
  }) {
    return _then(InitialSuccess<T>(
      result == freezed ? _value.result : result as T,
    ));
  }
}

class _$InitialSuccess<T> implements InitialSuccess<T> {
  const _$InitialSuccess(this.result) : assert(result != null);

  @override
  final T result;

  @override
  String toString() {
    return 'PagedCallState<$T>.initialSuccess(result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InitialSuccess<T> &&
            (identical(other.result, result) ||
                const DeepCollectionEquality().equals(other.result, result)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(result);

  @override
  $InitialSuccessCopyWith<T, InitialSuccess<T>> get copyWith =>
      _$InitialSuccessCopyWithImpl<T, InitialSuccess<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initialProgress(),
    @required Result initialSuccess(T result),
    @required Result initialError(RKString errorMessage),
    @required Result additionalProgress(),
    @required Result additionalSuccess(T result),
    @required Result additionalError(RKString errorMessage),
  }) {
    assert(initialProgress != null);
    assert(initialSuccess != null);
    assert(initialError != null);
    assert(additionalProgress != null);
    assert(additionalSuccess != null);
    assert(additionalError != null);
    return initialSuccess(result);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initialProgress(),
    Result initialSuccess(T result),
    Result initialError(RKString errorMessage),
    Result additionalProgress(),
    Result additionalSuccess(T result),
    Result additionalError(RKString errorMessage),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initialSuccess != null) {
      return initialSuccess(result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initialProgress(InitialProgress<T> value),
    @required Result initialSuccess(InitialSuccess<T> value),
    @required Result initialError(InitialError<T> value),
    @required Result additionalProgress(AdditionalProgress<T> value),
    @required Result additionalSuccess(AdditionalSuccess<T> value),
    @required Result additionalError(AdditionalError<T> value),
  }) {
    assert(initialProgress != null);
    assert(initialSuccess != null);
    assert(initialError != null);
    assert(additionalProgress != null);
    assert(additionalSuccess != null);
    assert(additionalError != null);
    return initialSuccess(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initialProgress(InitialProgress<T> value),
    Result initialSuccess(InitialSuccess<T> value),
    Result initialError(InitialError<T> value),
    Result additionalProgress(AdditionalProgress<T> value),
    Result additionalSuccess(AdditionalSuccess<T> value),
    Result additionalError(AdditionalError<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initialSuccess != null) {
      return initialSuccess(this);
    }
    return orElse();
  }
}

abstract class InitialSuccess<T> implements PagedCallState<T> {
  const factory InitialSuccess(T result) = _$InitialSuccess<T>;

  T get result;
  $InitialSuccessCopyWith<T, InitialSuccess<T>> get copyWith;
}

abstract class $InitialErrorCopyWith<T, $Res> {
  factory $InitialErrorCopyWith(
          InitialError<T> value, $Res Function(InitialError<T>) then) =
      _$InitialErrorCopyWithImpl<T, $Res>;
  $Res call({RKString errorMessage});
}

class _$InitialErrorCopyWithImpl<T, $Res>
    extends _$PagedCallStateCopyWithImpl<T, $Res>
    implements $InitialErrorCopyWith<T, $Res> {
  _$InitialErrorCopyWithImpl(
      InitialError<T> _value, $Res Function(InitialError<T>) _then)
      : super(_value, (v) => _then(v as InitialError<T>));

  @override
  InitialError<T> get _value => super._value as InitialError<T>;

  @override
  $Res call({
    Object errorMessage = freezed,
  }) {
    return _then(InitialError<T>(
      errorMessage == freezed ? _value.errorMessage : errorMessage as RKString,
    ));
  }
}

class _$InitialError<T> implements InitialError<T> {
  const _$InitialError(this.errorMessage) : assert(errorMessage != null);

  @override
  final RKString errorMessage;

  @override
  String toString() {
    return 'PagedCallState<$T>.initialError(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InitialError<T> &&
            (identical(other.errorMessage, errorMessage) ||
                const DeepCollectionEquality()
                    .equals(other.errorMessage, errorMessage)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(errorMessage);

  @override
  $InitialErrorCopyWith<T, InitialError<T>> get copyWith =>
      _$InitialErrorCopyWithImpl<T, InitialError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initialProgress(),
    @required Result initialSuccess(T result),
    @required Result initialError(RKString errorMessage),
    @required Result additionalProgress(),
    @required Result additionalSuccess(T result),
    @required Result additionalError(RKString errorMessage),
  }) {
    assert(initialProgress != null);
    assert(initialSuccess != null);
    assert(initialError != null);
    assert(additionalProgress != null);
    assert(additionalSuccess != null);
    assert(additionalError != null);
    return initialError(errorMessage);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initialProgress(),
    Result initialSuccess(T result),
    Result initialError(RKString errorMessage),
    Result additionalProgress(),
    Result additionalSuccess(T result),
    Result additionalError(RKString errorMessage),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initialError != null) {
      return initialError(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initialProgress(InitialProgress<T> value),
    @required Result initialSuccess(InitialSuccess<T> value),
    @required Result initialError(InitialError<T> value),
    @required Result additionalProgress(AdditionalProgress<T> value),
    @required Result additionalSuccess(AdditionalSuccess<T> value),
    @required Result additionalError(AdditionalError<T> value),
  }) {
    assert(initialProgress != null);
    assert(initialSuccess != null);
    assert(initialError != null);
    assert(additionalProgress != null);
    assert(additionalSuccess != null);
    assert(additionalError != null);
    return initialError(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initialProgress(InitialProgress<T> value),
    Result initialSuccess(InitialSuccess<T> value),
    Result initialError(InitialError<T> value),
    Result additionalProgress(AdditionalProgress<T> value),
    Result additionalSuccess(AdditionalSuccess<T> value),
    Result additionalError(AdditionalError<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initialError != null) {
      return initialError(this);
    }
    return orElse();
  }
}

abstract class InitialError<T> implements PagedCallState<T> {
  const factory InitialError(RKString errorMessage) = _$InitialError<T>;

  RKString get errorMessage;
  $InitialErrorCopyWith<T, InitialError<T>> get copyWith;
}

abstract class $AdditionalProgressCopyWith<T, $Res> {
  factory $AdditionalProgressCopyWith(AdditionalProgress<T> value,
          $Res Function(AdditionalProgress<T>) then) =
      _$AdditionalProgressCopyWithImpl<T, $Res>;
}

class _$AdditionalProgressCopyWithImpl<T, $Res>
    extends _$PagedCallStateCopyWithImpl<T, $Res>
    implements $AdditionalProgressCopyWith<T, $Res> {
  _$AdditionalProgressCopyWithImpl(
      AdditionalProgress<T> _value, $Res Function(AdditionalProgress<T>) _then)
      : super(_value, (v) => _then(v as AdditionalProgress<T>));

  @override
  AdditionalProgress<T> get _value => super._value as AdditionalProgress<T>;
}

class _$AdditionalProgress<T> implements AdditionalProgress<T> {
  const _$AdditionalProgress();

  @override
  String toString() {
    return 'PagedCallState<$T>.additionalProgress()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is AdditionalProgress<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initialProgress(),
    @required Result initialSuccess(T result),
    @required Result initialError(RKString errorMessage),
    @required Result additionalProgress(),
    @required Result additionalSuccess(T result),
    @required Result additionalError(RKString errorMessage),
  }) {
    assert(initialProgress != null);
    assert(initialSuccess != null);
    assert(initialError != null);
    assert(additionalProgress != null);
    assert(additionalSuccess != null);
    assert(additionalError != null);
    return additionalProgress();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initialProgress(),
    Result initialSuccess(T result),
    Result initialError(RKString errorMessage),
    Result additionalProgress(),
    Result additionalSuccess(T result),
    Result additionalError(RKString errorMessage),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (additionalProgress != null) {
      return additionalProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initialProgress(InitialProgress<T> value),
    @required Result initialSuccess(InitialSuccess<T> value),
    @required Result initialError(InitialError<T> value),
    @required Result additionalProgress(AdditionalProgress<T> value),
    @required Result additionalSuccess(AdditionalSuccess<T> value),
    @required Result additionalError(AdditionalError<T> value),
  }) {
    assert(initialProgress != null);
    assert(initialSuccess != null);
    assert(initialError != null);
    assert(additionalProgress != null);
    assert(additionalSuccess != null);
    assert(additionalError != null);
    return additionalProgress(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initialProgress(InitialProgress<T> value),
    Result initialSuccess(InitialSuccess<T> value),
    Result initialError(InitialError<T> value),
    Result additionalProgress(AdditionalProgress<T> value),
    Result additionalSuccess(AdditionalSuccess<T> value),
    Result additionalError(AdditionalError<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (additionalProgress != null) {
      return additionalProgress(this);
    }
    return orElse();
  }
}

abstract class AdditionalProgress<T> implements PagedCallState<T> {
  const factory AdditionalProgress() = _$AdditionalProgress<T>;
}

abstract class $AdditionalSuccessCopyWith<T, $Res> {
  factory $AdditionalSuccessCopyWith(AdditionalSuccess<T> value,
          $Res Function(AdditionalSuccess<T>) then) =
      _$AdditionalSuccessCopyWithImpl<T, $Res>;
  $Res call({T result});
}

class _$AdditionalSuccessCopyWithImpl<T, $Res>
    extends _$PagedCallStateCopyWithImpl<T, $Res>
    implements $AdditionalSuccessCopyWith<T, $Res> {
  _$AdditionalSuccessCopyWithImpl(
      AdditionalSuccess<T> _value, $Res Function(AdditionalSuccess<T>) _then)
      : super(_value, (v) => _then(v as AdditionalSuccess<T>));

  @override
  AdditionalSuccess<T> get _value => super._value as AdditionalSuccess<T>;

  @override
  $Res call({
    Object result = freezed,
  }) {
    return _then(AdditionalSuccess<T>(
      result == freezed ? _value.result : result as T,
    ));
  }
}

class _$AdditionalSuccess<T> implements AdditionalSuccess<T> {
  const _$AdditionalSuccess(this.result) : assert(result != null);

  @override
  final T result;

  @override
  String toString() {
    return 'PagedCallState<$T>.additionalSuccess(result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdditionalSuccess<T> &&
            (identical(other.result, result) ||
                const DeepCollectionEquality().equals(other.result, result)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(result);

  @override
  $AdditionalSuccessCopyWith<T, AdditionalSuccess<T>> get copyWith =>
      _$AdditionalSuccessCopyWithImpl<T, AdditionalSuccess<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initialProgress(),
    @required Result initialSuccess(T result),
    @required Result initialError(RKString errorMessage),
    @required Result additionalProgress(),
    @required Result additionalSuccess(T result),
    @required Result additionalError(RKString errorMessage),
  }) {
    assert(initialProgress != null);
    assert(initialSuccess != null);
    assert(initialError != null);
    assert(additionalProgress != null);
    assert(additionalSuccess != null);
    assert(additionalError != null);
    return additionalSuccess(result);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initialProgress(),
    Result initialSuccess(T result),
    Result initialError(RKString errorMessage),
    Result additionalProgress(),
    Result additionalSuccess(T result),
    Result additionalError(RKString errorMessage),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (additionalSuccess != null) {
      return additionalSuccess(result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initialProgress(InitialProgress<T> value),
    @required Result initialSuccess(InitialSuccess<T> value),
    @required Result initialError(InitialError<T> value),
    @required Result additionalProgress(AdditionalProgress<T> value),
    @required Result additionalSuccess(AdditionalSuccess<T> value),
    @required Result additionalError(AdditionalError<T> value),
  }) {
    assert(initialProgress != null);
    assert(initialSuccess != null);
    assert(initialError != null);
    assert(additionalProgress != null);
    assert(additionalSuccess != null);
    assert(additionalError != null);
    return additionalSuccess(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initialProgress(InitialProgress<T> value),
    Result initialSuccess(InitialSuccess<T> value),
    Result initialError(InitialError<T> value),
    Result additionalProgress(AdditionalProgress<T> value),
    Result additionalSuccess(AdditionalSuccess<T> value),
    Result additionalError(AdditionalError<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (additionalSuccess != null) {
      return additionalSuccess(this);
    }
    return orElse();
  }
}

abstract class AdditionalSuccess<T> implements PagedCallState<T> {
  const factory AdditionalSuccess(T result) = _$AdditionalSuccess<T>;

  T get result;
  $AdditionalSuccessCopyWith<T, AdditionalSuccess<T>> get copyWith;
}

abstract class $AdditionalErrorCopyWith<T, $Res> {
  factory $AdditionalErrorCopyWith(
          AdditionalError<T> value, $Res Function(AdditionalError<T>) then) =
      _$AdditionalErrorCopyWithImpl<T, $Res>;
  $Res call({RKString errorMessage});
}

class _$AdditionalErrorCopyWithImpl<T, $Res>
    extends _$PagedCallStateCopyWithImpl<T, $Res>
    implements $AdditionalErrorCopyWith<T, $Res> {
  _$AdditionalErrorCopyWithImpl(
      AdditionalError<T> _value, $Res Function(AdditionalError<T>) _then)
      : super(_value, (v) => _then(v as AdditionalError<T>));

  @override
  AdditionalError<T> get _value => super._value as AdditionalError<T>;

  @override
  $Res call({
    Object errorMessage = freezed,
  }) {
    return _then(AdditionalError<T>(
      errorMessage == freezed ? _value.errorMessage : errorMessage as RKString,
    ));
  }
}

class _$AdditionalError<T> implements AdditionalError<T> {
  const _$AdditionalError(this.errorMessage) : assert(errorMessage != null);

  @override
  final RKString errorMessage;

  @override
  String toString() {
    return 'PagedCallState<$T>.additionalError(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdditionalError<T> &&
            (identical(other.errorMessage, errorMessage) ||
                const DeepCollectionEquality()
                    .equals(other.errorMessage, errorMessage)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(errorMessage);

  @override
  $AdditionalErrorCopyWith<T, AdditionalError<T>> get copyWith =>
      _$AdditionalErrorCopyWithImpl<T, AdditionalError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initialProgress(),
    @required Result initialSuccess(T result),
    @required Result initialError(RKString errorMessage),
    @required Result additionalProgress(),
    @required Result additionalSuccess(T result),
    @required Result additionalError(RKString errorMessage),
  }) {
    assert(initialProgress != null);
    assert(initialSuccess != null);
    assert(initialError != null);
    assert(additionalProgress != null);
    assert(additionalSuccess != null);
    assert(additionalError != null);
    return additionalError(errorMessage);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initialProgress(),
    Result initialSuccess(T result),
    Result initialError(RKString errorMessage),
    Result additionalProgress(),
    Result additionalSuccess(T result),
    Result additionalError(RKString errorMessage),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (additionalError != null) {
      return additionalError(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initialProgress(InitialProgress<T> value),
    @required Result initialSuccess(InitialSuccess<T> value),
    @required Result initialError(InitialError<T> value),
    @required Result additionalProgress(AdditionalProgress<T> value),
    @required Result additionalSuccess(AdditionalSuccess<T> value),
    @required Result additionalError(AdditionalError<T> value),
  }) {
    assert(initialProgress != null);
    assert(initialSuccess != null);
    assert(initialError != null);
    assert(additionalProgress != null);
    assert(additionalSuccess != null);
    assert(additionalError != null);
    return additionalError(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initialProgress(InitialProgress<T> value),
    Result initialSuccess(InitialSuccess<T> value),
    Result initialError(InitialError<T> value),
    Result additionalProgress(AdditionalProgress<T> value),
    Result additionalSuccess(AdditionalSuccess<T> value),
    Result additionalError(AdditionalError<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (additionalError != null) {
      return additionalError(this);
    }
    return orElse();
  }
}

abstract class AdditionalError<T> implements PagedCallState<T> {
  const factory AdditionalError(RKString errorMessage) = _$AdditionalError<T>;

  RKString get errorMessage;
  $AdditionalErrorCopyWith<T, AdditionalError<T>> get copyWith;
}
