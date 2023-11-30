import 'package:equatable/equatable.dart';

class ProductItemEntity extends Equatable {
  const ProductItemEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  final int id;
  final String name;
  final String imageUrl;
  final int price;

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        price,
      ];
}
