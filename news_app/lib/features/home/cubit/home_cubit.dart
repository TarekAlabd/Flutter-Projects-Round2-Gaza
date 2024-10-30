import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/services/cache_services.dart';
import 'package:news_app/features/home/models/top_headlines_body.dart';
import 'package:news_app/features/home/models/top_headlines_response.dart';
import 'package:news_app/features/home/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final homeServices = HomeServices();
  final cacheServices = CacheServices();

  Future<void> getHomeCarousel() async {
    emit(HomeCarouselLoading());
    try {
      final body = TopHeadlinesBody(
        country: 'us',
        pageSize: 5,
        category: 'technology',
      );
      final topHeadlineResponse = await homeServices.getTopHeadlines(body);
      emit(HomeCarouselLoaded(topHeadlineResponse.articles ?? []));
    } catch (e) {
      emit(HomeCarouselError(e.toString()));
    }
  }

  Future<void> getHomeList() async {
    emit(HomeListLoading());
    try {
      final body = TopHeadlinesBody(
        country: 'us',
        pageSize: 20,
      );
      final topHeadlineResponse = await homeServices.getTopHeadlines(body);
      var articles = topHeadlineResponse.articles;
      for (var i = 0; i < articles!.length; i++) {
        final chosenArticle =
            await cacheServices.getString('favorite_${articles[i].title}');
        if (chosenArticle != null) {
          articles[i] = articles[i].copyWith(isFavorite: true);
        }
      }
      emit(HomeListLoaded(articles ?? []));
    } catch (e) {
      emit(HomeListError(e.toString()));
    }
  }

  Future<void> setFavorite(Article article) async {
    emit(HomeFavoriteLoading(article.title!));
    try {
      debugPrint(json.encode(article.toMap()));
      final chosenArticle =
          await cacheServices.getString('favorite_${article.title}');
      if (chosenArticle != null) {
        await cacheServices.remove('favorite_${article.title}');
      } else {
        await cacheServices.setString(
            'favorite_${article.title}', json.encode(article.toMap()));
      }
      emit(HomeFavoriteLoaded(article.title!, chosenArticle == null));
    } catch (e) {
      emit(HomeFavoriteError(e.toString()));
    }
  }
}
