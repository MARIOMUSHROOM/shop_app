part of 'saved_bloc.dart';

abstract class SavedState extends Equatable {
  const SavedState();

  @override
  List<Object?> get props => [];
}

class SavedInitial extends SavedState {}

class SavedEmpty extends SavedState {}

class SavedLoading extends SavedState {}

class SavedLoaded extends SavedState {
  final List<FavoriteItemEntity> result;
  const SavedLoaded(this.result);
  @override
  List<Object?> get props => [result];
}

class SavedOnlyLoaded extends SavedState {
  final FavoriteItemEntity result;
  const SavedOnlyLoaded(this.result);
  @override
  List<Object?> get props => [result];
}

class SavedLoadFailue extends SavedState {
  final String message;

  const SavedLoadFailue(this.message);

  @override
  List<Object?> get props => [message];
}
