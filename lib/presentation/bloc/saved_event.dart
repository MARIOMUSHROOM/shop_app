part of 'saved_bloc.dart';

abstract class SavedEvent extends Equatable {
  const SavedEvent();

  @override
  List<Object?> get props => [];
}

class OnLoadSaved extends SavedEvent {
  const OnLoadSaved();
  @override
  List<Object?> get props => [];
}

class OnRemoveSaved extends SavedEvent {
  OnRemoveSaved(this.item);
  FavoriteItemEntity item;
  @override
  List<Object?> get props => [item];
}

class OnRemoveAllSaved extends SavedEvent {
  const OnRemoveAllSaved();
  @override
  List<Object?> get props => [];
}

class OnLoadOnlySaved extends SavedEvent {
  OnLoadOnlySaved(this.item);
  ProductItemEntity item;
  @override
  List<Object?> get props => [item];
}

class OnAddSaved extends SavedEvent {
  OnAddSaved(this.item);
  ProductItemEntity item;
  @override
  List<Object?> get props => [item];
}
