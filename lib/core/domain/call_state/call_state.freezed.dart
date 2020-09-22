// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of call_state;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
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
  Error<T> error<T>(PlainLocalizedString message) {
    return Error<T>(
      message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $CallState = _$CallStateTearOff();

/// @nodoc
mixin _$CallState<T> {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result progress(),
    @required Result success(@nullable T result),
    @required Result error(PlainLocalizedString message),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result progress(),
    Result success(@nullable T result),
    Result error(PlainLocalizedString message),
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

/// @nodoc
abstract class $CallStateCopyWith<T, $Res> {
  factory $CallStateCopyWith(
          CallState<T> value, $Res Function(CallState<T>) then) =
      _$CallStateCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$CallStateCopyWithImpl<T, $Res> implements $CallStateCopyWith<T, $Res> {
  _$CallStateCopyWithImpl(this._value, this._then);

  final CallState<T> _value;
  // ignore: unused_field
  final $Res Function(CallState<T>) _then;
}

/// @nodoc
abstract class $ProgressCopyWith<T, $Res> {
  factory $ProgressCopyWith(
          Progress<T> value, $Res Function(Progress<T>) then) =
      _$ProgressCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$ProgressCopyWithImpl<T, $Res> extends _$CallStateCopyWithImpl<T, $Res>
    implements $ProgressCopyWith<T, $Res> {
  _$ProgressCopyWithImpl(Progress<T> _value, $Res Function(Progress<T>) _then)
      : super(_value, (v) => _then(v as Progress<T>));

  @override
  Progress<T> get _value => super._value as Progress<T>;
}

/// @nodoc
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
    @required Result error(PlainLocalizedString message),
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
    Result error(PlainLocalizedString message),
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

/// @nodoc
abstract class $SuccessCopyWith<T, $Res> {
  factory $SuccessCopyWith(Success<T> value, $Res Function(Success<T>) then) =
      _$SuccessCopyWithImpl<T, $Res>;
  $Res call({@nullable T result});
}

/// @nodoc
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

/// @nodoc
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
    @required Result error(PlainLocalizedString message),
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
    Result error(PlainLocalizedString message),
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

/// @nodoc
abstract class $ErrorCopyWith<T, $Res> {
  factory $ErrorCopyWith(Error<T> value, $Res Function(Error<T>) then) =
      _$ErrorCopyWithImpl<T, $Res>;

  $Res call({PlainLocalizedString message});
}

/// @nodoc
class _$ErrorCopyWithImpl<T, $Res> extends _$CallStateCopyWithImpl<T, $Res>
    implements $ErrorCopyWith<T, $Res> {
  _$ErrorCopyWithImpl(Error<T> _value, $Res Function(Error<T>) _then)
      : super(_value, (v) => _then(v as Error<T>));

  @override
  Error<T> get _value => super._value as Error<T>;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(Error<T>(
      message == freezed ? _value.message : message as PlainLocalizedString,
    ));
  }
}

/// @nodoc
class _$Error<T> implements Error<T> {
  const _$Error(this.message) : assert(message != null);

  @override
  final PlainLocalizedString message;

  @override
  String toString() {
    return 'CallState<$T>.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Error<T> &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @override
  $ErrorCopyWith<T, Error<T>> get copyWith =>
      _$ErrorCopyWithImpl<T, Error<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result progress(),
    @required Result success(@nullable T result),
    @required Result error(PlainLocalizedString message),
  }) {
    assert(progress != null);
    assert(success != null);
    assert(error != null);
    return error(message);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result progress(),
    Result success(@nullable T result),
    Result error(PlainLocalizedString message),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(message);
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
  const factory Error(PlainLocalizedString message) = _$Error<T>;

  PlainLocalizedString get message;

  $ErrorCopyWith<T, Error<T>> get copyWith;
}
