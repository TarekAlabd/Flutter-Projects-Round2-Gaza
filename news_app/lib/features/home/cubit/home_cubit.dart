import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/models/top_headlines_body.dart';
import 'package:news_app/features/home/models/top_headlines_response.dart';
import 'package:news_app/features/home/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final homeServices = HomeServices();

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
      emit(HomeListLoaded(topHeadlineResponse.articles ?? []));
    } catch (e) {
      emit(HomeListError(e.toString()));
    }
  }
}
