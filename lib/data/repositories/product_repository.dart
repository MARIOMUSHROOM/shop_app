import 'dart:io';

import 'package:shop_app/core/error/exception.dart';
import 'package:shop_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_app/data/data_source/product_data_source.dart';
import 'package:shop_app/domain/entities/product_item.dart';
import 'package:shop_app/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductDataSource productDataSource;
  ProductRepositoryImpl({required this.productDataSource});

  @override
  Future<Either<Failure, List<ProductItemEntity>>> getCurrentProduct() async {
    try {
      List<ProductItemEntity> list = [];
      final result = await productDataSource.getCurrentProduct();
      for (var i = 0; i < result.productItems!.length; i++) {
        list.add(result.productItems![i].toEntity());
      }
      return Right(list);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
