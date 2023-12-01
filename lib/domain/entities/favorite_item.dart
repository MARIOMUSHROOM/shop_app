import 'package:equatable/equatable.dart';
import 'package:shop_app/domain/entities/product_item.dart';

class FavoriteItemEntity extends Equatable {
  FavoriteItemEntity({
    required this.isSelected,
    required this.product,
  });

  bool isSelected;
  ProductItemEntity product;

  @override
  List<Object?> get props => [
        isSelected,
        product,
      ];
}
