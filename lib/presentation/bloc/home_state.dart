part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeEmpty extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProductItemEntity> result;

  const HomeLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class HomeLoadFailue extends HomeState {
  final String message;

  const HomeLoadFailue(this.message);

  @override
  List<Object?> get props => [message];
}
