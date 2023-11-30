import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_app/domain/entities/product_item.dart';
import 'package:shop_app/domain/usecases/get_current_product.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentProductUseCase _getCurrentProductUseCase;
  HomeBloc(this._getCurrentProductUseCase) : super(HomeEmpty()) {
    on<OnLoadProduct>(
      (event, emit) async {
        emit(HomeLoading());
        final result = await _getCurrentProductUseCase.execute();
        result.fold(
          (failure) {
            emit(HomeLoadFailue(failure.message));
          },
          (data) {
            emit(HomeLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
