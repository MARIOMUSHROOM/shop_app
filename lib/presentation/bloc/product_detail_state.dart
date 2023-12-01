part of 'product_detail_bloc.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object?> get props => [];
}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailEmpty extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final ProductItemEntity result;

  const ProductDetailLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class ProductDetailLoadFailue extends ProductDetailState {
  final String message;

  const ProductDetailLoadFailue(this.message);

  @override
  List<Object?> get props => [message];
}
