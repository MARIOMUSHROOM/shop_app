part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object?> get props => [];
}

class OnLoadProductDetail extends ProductDetailEvent {
  OnLoadProductDetail(this.id);
  int id;
  @override
  List<Object?> get props => [id];
}
