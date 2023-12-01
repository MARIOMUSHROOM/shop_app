import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:shop_app/domain/entities/product_item.dart';
import 'package:shop_app/domain/usecases/get_product_by_id.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductByIdUseCase _getProductByIdUseCase;
  ProductDetailBloc(this._getProductByIdUseCase)
      : super(ProductDetailInitial()) {
    on<OnLoadProductDetail>(
      (event, emit) async {
        emit(ProductDetailLoading());
        final result = await _getProductByIdUseCase.execute(event.id);
        result.fold(
          (failure) {
            emit(ProductDetailLoadFailue(failure.message));
          },
          (data) {
            emit(ProductDetailLoaded(data));
          },
        );
      },
    );
  }
}
