import 'package:get_it/get_it.dart';
import 'package:shop_app/data/data_source/product_data_source.dart';
import 'package:shop_app/data/repositories/product_repository.dart';
import 'package:shop_app/domain/repositories/product_repository.dart';
import 'package:shop_app/domain/usecases/get_current_product.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/presentation/bloc/cart_bloc.dart';
import 'package:shop_app/presentation/bloc/home_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  // bloc
  locator.registerFactory(() => HomeBloc(locator()));
  locator.registerFactory(() => CartBloc());

  // usecase
  locator.registerLazySingleton(() => GetCurrentProductUseCase(locator()));

  // repository
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(productDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<ProductDataSource>(
    () => ProductDataSourceImpl(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
