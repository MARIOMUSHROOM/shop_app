part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartEmpty extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemEntity> result;
  final num total;
  const CartLoaded(this.result, this.total);

  @override
  List<Object?> get props => [result];
}

class CartLoadFailue extends CartState {
  final String message;

  const CartLoadFailue(this.message);

  @override
  List<Object?> get props => [message];
}
