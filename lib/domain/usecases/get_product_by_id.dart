import 'package:dartz/dartz.dart';
import 'package:shop_app/core/error/failure.dart';
import 'package:shop_app/domain/entities/product_item.dart';
import 'package:shop_app/domain/repositories/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository productRepository;

  GetProductByIdUseCase(this.productRepository);

  Future<Either<Failure, ProductItemEntity>> execute(int id) {
    return productRepository.getProductById(id);
  }
}
