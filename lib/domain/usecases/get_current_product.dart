import 'package:dartz/dartz.dart';
import 'package:shop_app/core/error/failure.dart';
import 'package:shop_app/domain/entities/product_item.dart';
import 'package:shop_app/domain/repositories/product_repository.dart';

class GetCurrentProductUseCase {
  final ProductRepository productRepository;

  GetCurrentProductUseCase(this.productRepository);

  Future<Either<Failure, List<ProductItemEntity>>> execute() {
    return productRepository.getCurrentProduct();
  }
}
