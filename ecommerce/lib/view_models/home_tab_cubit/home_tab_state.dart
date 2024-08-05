part of 'home_tab_cubit.dart';

sealed class HomeTabState {}

final class HomeInitial extends HomeTabState {}

final class HomeLoading extends HomeTabState {}

final class HomeLoaded extends HomeTabState {
  final List<String> announcementsImages;
  final List<ProductItemModel> products;

  HomeLoaded({
    required this.announcementsImages,
    required this.products,
  });
}

final class HomeError extends HomeTabState {
  final String message;

  HomeError({
    required this.message,
  });
}

final class SetFavoriteLoading extends HomeTabState {
  final String favoritedId;

  SetFavoriteLoading(this.favoritedId);
}

final class SetFavoriteSuccess extends HomeTabState {
  final String favoritedId;
  final bool isFavorite;

  SetFavoriteSuccess({required this.favoritedId, required this.isFavorite});
}

final class SetFavoriteError extends HomeTabState {
  final String message;

  SetFavoriteError({
    required this.message,
  });
}
