import 'package:equatable/equatable.dart';
import 'package:shop_app/domain/entities/product_item.dart';

class CartItemEntity extends Equatable {
  CartItemEntity({
    required this.quantity,
    required this.product,
  });

  num quantity;
  ProductItemEntity product;

  @override
  List<Object?> get props => [
        quantity,
        product,
      ];
}
