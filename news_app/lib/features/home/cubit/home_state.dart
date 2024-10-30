part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeCarouselLoading extends HomeState {}

final class HomeCarouselLoaded extends HomeState {
  final List<Article> topHeadlines;

  HomeCarouselLoaded(this.topHeadlines);
}

final class HomeCarouselError extends HomeState {
  final String message;

  HomeCarouselError(this.message);
}

final class HomeListLoading extends HomeState {}

final class HomeListLoaded extends HomeState {
  final List<Article> topHeadlines;

  HomeListLoaded(this.topHeadlines);
}

final class HomeListError extends HomeState {
  final String message;

  HomeListError(this.message);
}

final class HomeFavoriteLoading extends HomeState {
  final String title;

  HomeFavoriteLoading(this.title);
}

final class HomeFavoriteLoaded extends HomeState {
  final String title;
  final bool isFavorite;

  HomeFavoriteLoaded(
    this.title,
    this.isFavorite,
  );
}

final class HomeFavoriteError extends HomeState {
  final String message;

  HomeFavoriteError(this.message);
}
