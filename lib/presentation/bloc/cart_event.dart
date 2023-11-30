part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class OnloadCart extends CartEvent {
  OnloadCart();
  @override
  List<Object?> get props => [];
}

class AddtoCart extends CartEvent {
  AddtoCart(this.context, this.product);
  BuildContext context;
  ProductItemEntity product;
  @override
  List<Object?> get props => [product];
}

class RemoveFromCart extends CartEvent {
  RemoveFromCart(this.cartItem);
  CartItemEntity cartItem;
  @override
  List<Object?> get props => [cartItem];
}

class AddQuantity extends CartEvent {
  AddQuantity(this.cartItem);
  CartItemEntity cartItem;
  @override
  List<Object?> get props => [cartItem];
}

class MinusQuantity extends CartEvent {
  MinusQuantity(this.cartItem);
  CartItemEntity cartItem;
  @override
  List<Object?> get props => [cartItem];
}
