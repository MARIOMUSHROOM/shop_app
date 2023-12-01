import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/domain/entities/cart_item.dart';
import 'package:shop_app/domain/entities/favorite_item.dart';
import 'package:shop_app/domain/entities/product_item.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  List<FavoriteItemEntity> _favoriteList = [];
  SavedBloc() : super(SavedInitial()) {
    on<OnLoadSaved>(
      (event, emit) async {
        emit(SavedLoaded(_favoriteList));
      },
    );
    on<OnRemoveSaved>(
      (event, emit) async {
        emit(SavedLoading());
        _favoriteList.removeWhere(
          (element) => element.product.id == event.item.product.id,
        );
        emit(SavedLoaded(_favoriteList));
      },
    );
    on<OnRemoveAllSaved>(
      (event, emit) async {
        emit(SavedLoading());
        _favoriteList = [];
        emit(SavedLoaded(_favoriteList));
      },
    );
    on<OnLoadOnlySaved>(
      (event, emit) async {
        emit(SavedLoading());
        FavoriteItemEntity convert = await thisProductInFavorite(event.item);
        emit(SavedOnlyLoaded(convert));
      },
    );
    on<OnAddSaved>(
      (event, emit) async {
        emit(SavedLoading());
        FavoriteItemEntity convert = await thisProductInFavorite(event.item);
        if (convert.isSelected == false) {
          convert.isSelected = true;
          _favoriteList.add(convert);
          emit(SavedOnlyLoaded(convert));
        } else {
          convert.isSelected = false;
          _favoriteList.removeWhere(
            (element) => element.product.id == event.item.id,
          );
        }
        emit(SavedOnlyLoaded(convert));
      },
    );
  }

  Future<FavoriteItemEntity> thisProductInFavorite(
      ProductItemEntity product) async {
    FavoriteItemEntity convert = FavoriteItemEntity(
      product: product,
      isSelected: false,
    );
    for (var i = 0; i < _favoriteList.length; i++) {
      if (_favoriteList[i].product.id == product.id) {
        convert.isSelected = true;
      }
    }
    return convert;
  }
}
