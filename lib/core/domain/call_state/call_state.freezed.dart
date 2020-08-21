// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of call_state;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$CallStateTearOff {
  const _$CallStateTearOff();

// ignore: unused_element
  Progress<T> progress<T>() {
    return Progress<T>();
  }

// ignore: unused_element
  Success<T> success<T>(@nullable T result) {
    return Success<T>(
      result,
    );
  }

// ignore: unused_element
  Error<T> error<T>(RKString errorMessage) {
    return Error<T>(
      errorMessage,
    );
  }
}

// ignore: unused_element
const $CallState = _$CallStateTearOff();

mixin _$CallState<T> {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result progress(),
    @required Result success(@nullable T result),
    @required Result error(RKString errorMessage),
  });

  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result progress(),
    Result success(@nullable T result),
    Result error(RKString errorMessage),
    @required Result orElse(),
  });

  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result progress(Progress<T> value),
    @required Result success(Success<T> value),
    @required Result error(Error<T> value),
  });

  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result progress(Progress<T> value),
    Result success(Success<T> value),
    Result error(Error<T> value),
    @required Result orElse(),
  });
}

abstract class $CallStateCopyWith<T, $Res> {
  factory $CallStateCopyWith(
          CallState<T> value, $Res Function(CallState<T>) then) =
      _$CallStateCopyWithImpl<T, $Res>;
}

class _$CallStateCopyWithImpl<T, $Res> implements $CallStateCopyWith<T, $Res> {
  _$CallStateCopyWithImpl(this._value, this._then);

  final CallState<T> _value;

  // ignore: unused_field
  final $Res Function(CallState<T>) _then;
}

abstract class $ProgressCopyWith<T, $Res> {
  factory $ProgressCopyWith(
          Progress<T> value, $Res Function(Progress<T>) then) =
      _$ProgressCopyWithImpl<T, $Res>;
}

class _$ProgressCopyWithImpl<T, $Res> extends _$CallStateCopyWithImpl<T, $Res>
    implements $ProgressCopyWith<T, $Res> {
  _$ProgressCopyWithImpl(Progress<T> _value, $Res Function(Progress<T>) _then)
      : super(_value, (v) => _then(v as Progress<T>));

  @override
  Progress<T> get _value => super._value as Progress<T>;
}

class _$Progress<T> implements Progress<T> {
  const _$Progress();

  @override
  String toString() {
    return 'CallState<$T>.progress()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Progress<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result progress(),
    @required Result success(@nullable T result),
    @required Result error(RKString errorMessage),
  }) {
    assert(progress != null);
    assert(success != null);
    assert(error != null);
    return progress();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result progress(),
    Result success(@nullable T result),
    Result error(RKString errorMessage),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (progress != null) {
      return progress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result progress(Progress<T> value),
    @required Result success(Success<T> value),
    @required Result error(Error<T> value),
  }) {
    assert(progress != null);
    assert(success != null);
    assert(error != null);
    return progress(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result progress(Progress<T> value),
    Result success(Success<T> value),
    Result error(Error<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (progress != null) {
      return progress(this);
    }
    return orElse();
  }
}

abstract class Progress<T> implements CallState<T> {
  const factory Progress() = _$Progress<T>;
}

abstract class $SuccessCopyWith<T, $Res> {
  factory $SuccessCopyWith(Success<T> value, $Res Function(Success<T>) then) =
      _$SuccessCopyWithImpl<T, $Res>;

  $Res call({@nullable T result});
}

class _$SuccessCopyWithImpl<T, $Res> extends _$CallStateCopyWithImpl<T, $Res>
    implements $SuccessCopyWith<T, $Res> {
  _$SuccessCopyWithImpl(Success<T> _value, $Res Function(Success<T>) _then)
      : super(_value, (v) => _then(v as Success<T>));

  @override
  Success<T> get _value => super._value as Success<T>;

  @override
  $Res call({
    Object result = freezed,
  }) {
    return _then(Success<T>(
      result == freezed ? _value.result : result as T,
    ));
  }
}

class _$Success<T> implements Success<T> {
  const _$Success(@nullable this.result);

  @override
  @nullable
  final T result;

  @override
  String toString() {
    return 'CallState<$T>.success(result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Success<T> &&
            (identical(other.result, result) ||
                const DeepCollectionEquality().equals(other.result, result)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(result);

  @override
  $SuccessCopyWith<T, Success<T>> get copyWith =>
      _$SuccessCopyWithImpl<T, Success<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result progress(),
    @required Result success(@nullable T result),
    @required Result error(RKString errorMessage),
  }) {
    assert(progress != null);
    assert(success != null);
    assert(error != null);
    return success(result);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result progress(),
    Result success(@nullable T result),
    Result error(RKString errorMessage),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success(result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result progress(Progress<T> value),
    @required Result success(Success<T> value),
    @required Result error(Error<T> value),
  }) {
    assert(progress != null);
    assert(success != null);
    assert(error != null);
    return success(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result progress(Progress<T> value),
    Result success(Success<T> value),
    Result error(Error<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class Success<T> implements CallState<T> {
  const factory Success(@nullable T result) = _$Success<T>;

  @nullable
  T get result;

  $SuccessCopyWith<T, Success<T>> get copyWith;
}

abstract class $ErrorCopyWith<T, $Res> {
  factory $ErrorCopyWith(Error<T> value, $Res Function(Error<T>) then) =
      _$ErrorCopyWithImpl<T, $Res>;

  $Res call({RKString errorMessage});
}

class _$ErrorCopyWithImpl<T, $Res> extends _$CallStateCopyWithImpl<T, $Res>
    implements $ErrorCopyWith<T, $Res> {
  _$ErrorCopyWithImpl(Error<T> _value, $Res Function(Error<T>) _then)
      : super(_value, (v) => _then(v as Error<T>));

  @override
  Error<T> get _value => super._value as Error<T>;

  @override
  $Res call({
    Object errorMessage = freezed,
  }) {
    return _then(Error<T>(
      errorMessage == freezed ? _value.errorMessage : errorMessage as RKString,
    ));
  }
}

class _$Error<T> implements Error<T> {
  const _$Error(this.errorMessage) : assert(errorMessage != null);

  @override
  final RKString errorMessage;

  @override
  String toString() {
    return 'CallState<$T>.error(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Error<T> &&
            (identical(other.errorMessage, errorMessage) ||
                const DeepCollectionEquality()
                    .equals(other.errorMessage, errorMessage)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(errorMessage);

  @override
  $ErrorCopyWith<T, Error<T>> get copyWith =>
      _$ErrorCopyWithImpl<T, Error<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result progress(),
    @required Result success(@nullable T result),
    @required Result error(RKString errorMessage),
  }) {
    assert(progress != null);
    assert(success != null);
    assert(error != null);
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result progress(),
    Result success(@nullable T result),
    Result error(RKString errorMessage),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result progress(Progress<T> value),
    @required Result success(Success<T> value),
    @required Result error(Error<T> value),
  }) {
    assert(progress != null);
    assert(success != null);
    assert(error != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result progress(Progress<T> value),
    Result success(Success<T> value),
    Result error(Error<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error<T> implements CallState<T> {
  const factory Error(RKString errorMessage) = _$Error<T>;

  RKString get errorMessage;

  $ErrorCopyWith<T, Error<T>> get copyWith;
}
