import 'package:dartz/dartz.dart';
import 'package:shop_app/core/error/failure.dart';
import 'package:shop_app/domain/entities/product_item.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductItemEntity>>> getCurrentProduct();
}
