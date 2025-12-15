// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ProductListModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductListModel _$ProductListModelFromJson(Map<String, dynamic> json) {
  return _ProductListModel.fromJson(json);
}

/// @nodoc
mixin _$ProductListModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<ProductModel>? get products => throw _privateConstructorUsedError;
  List<AdsTxnModel>? get ads => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductListModelCopyWith<ProductListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductListModelCopyWith<$Res> {
  factory $ProductListModelCopyWith(
          ProductListModel value, $Res Function(ProductListModel) then) =
      _$ProductListModelCopyWithImpl<$Res, ProductListModel>;
  @useResult
  $Res call(
      {String status,
      int code,
      String message,
      List<ProductModel>? products,
      List<AdsTxnModel>? ads});
}

/// @nodoc
class _$ProductListModelCopyWithImpl<$Res, $Val extends ProductListModel>
    implements $ProductListModelCopyWith<$Res> {
  _$ProductListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? products = freezed,
    Object? ads = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>?,
      ads: freezed == ads
          ? _value.ads
          : ads // ignore: cast_nullable_to_non_nullable
              as List<AdsTxnModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductListModelImplCopyWith<$Res>
    implements $ProductListModelCopyWith<$Res> {
  factory _$$ProductListModelImplCopyWith(_$ProductListModelImpl value,
          $Res Function(_$ProductListModelImpl) then) =
      __$$ProductListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status,
      int code,
      String message,
      List<ProductModel>? products,
      List<AdsTxnModel>? ads});
}

/// @nodoc
class __$$ProductListModelImplCopyWithImpl<$Res>
    extends _$ProductListModelCopyWithImpl<$Res, _$ProductListModelImpl>
    implements _$$ProductListModelImplCopyWith<$Res> {
  __$$ProductListModelImplCopyWithImpl(_$ProductListModelImpl _value,
      $Res Function(_$ProductListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? products = freezed,
    Object? ads = freezed,
  }) {
    return _then(_$ProductListModelImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      products: freezed == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>?,
      ads: freezed == ads
          ? _value._ads
          : ads // ignore: cast_nullable_to_non_nullable
              as List<AdsTxnModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductListModelImpl implements _ProductListModel {
  _$ProductListModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      final List<ProductModel>? products,
      final List<AdsTxnModel>? ads})
      : _products = products,
        _ads = ads;

  factory _$ProductListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductListModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  final List<ProductModel>? _products;
  @override
  List<ProductModel>? get products {
    final value = _products;
    if (value == null) return null;
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<AdsTxnModel>? _ads;
  @override
  List<AdsTxnModel>? get ads {
    final value = _ads;
    if (value == null) return null;
    if (_ads is EqualUnmodifiableListView) return _ads;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ProductListModel(status: $status, code: $code, message: $message, products: $products, ads: $ads)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductListModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(other._ads, _ads));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      code,
      message,
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_ads));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductListModelImplCopyWith<_$ProductListModelImpl> get copyWith =>
      __$$ProductListModelImplCopyWithImpl<_$ProductListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductListModelImplToJson(
      this,
    );
  }
}

abstract class _ProductListModel implements ProductListModel {
  factory _ProductListModel(
      {required final String status,
      required final int code,
      required final String message,
      final List<ProductModel>? products,
      final List<AdsTxnModel>? ads}) = _$ProductListModelImpl;

  factory _ProductListModel.fromJson(Map<String, dynamic> json) =
      _$ProductListModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  List<ProductModel>? get products;
  @override
  List<AdsTxnModel>? get ads;
  @override
  @JsonKey(ignore: true)
  _$$ProductListModelImplCopyWith<_$ProductListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
