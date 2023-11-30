import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_app/domain/entities/cart_item.dart';
import 'package:shop_app/domain/entities/product_item.dart';
import 'package:shop_app/presentation/widgets/toast_widget.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartItemEntity> _cartList = [];
  num total = 0;
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {}
  CartBloc() : super(CartEmpty()) {
    on<OnloadCart>(
      (event, emit) async {
        await calculate();
        emit(CartLoaded(_cartList, total));
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<AddtoCart>(
      (event, emit) async {
        ProductItemEntity product = event.product;
        var inCart = thisProductInCart(product);
        if (inCart) {
          CartItemEntity item = _cartList.where((element) {
            return element.product.id == product.id;
          }).first;
          item.quantity = item.quantity + 1;
        } else {
          CartItemEntity item = CartItemEntity(product: product, quantity: 1);
          _cartList.add(item);
        }
        ToastWidget(event.context).show(message: "เพิ่มรายการสำเร็จ");
        await calculate();
        emit(CartLoaded(_cartList, total));
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<RemoveFromCart>(
      (event, emit) async {
        emit(CartLoading());
        CartItemEntity cartItem = event.cartItem;
        _cartList.removeWhere(
            (element) => element.product.id == cartItem.product.id);
        await calculate();
        emit(CartLoaded(_cartList, total));
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<AddQuantity>(
      (event, emit) async {
        emit(CartLoading());
        CartItemEntity item = _cartList.where((element) {
          return element.product.id == event.cartItem.product.id;
        }).first;
        item.quantity = item.quantity + 1;
        await calculate();
        emit(CartLoaded(_cartList, total));
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<MinusQuantity>(
      (event, emit) async {
        emit(CartLoading());
        CartItemEntity item = _cartList.where((element) {
          return element.product.id == event.cartItem.product.id;
        }).first;
        if (item.quantity > 1) {
          item.quantity = item.quantity - 1;
        }
        await calculate();
        emit(CartLoaded(_cartList, total));
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
  bool thisProductInCart(ProductItemEntity product) {
    bool check = _cartList.where((element) {
      return element.product.id == product.id;
    }).isNotEmpty;
    return check;
  }

  calculate() {
    total = 0;
    for (var i = 0; i < _cartList.length; i++) {
      num quantity = _cartList[i].quantity;
      num price = _cartList[i].product.price;
      num only = quantity * price;
      total = total + only;
    }
    log("calculated");
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
