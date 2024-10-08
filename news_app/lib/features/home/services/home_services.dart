import 'package:dio/dio.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/home/models/top_headlines_body.dart';
import 'package:news_app/features/home/models/top_headlines_response.dart';

class HomeServices {
  final aDio = Dio();

  Future<TopHeadlinesResponse> getTopHeadlines(
      TopHeadlinesBody queryParams) async {
    try {
      final headers = {
        'Authorization': "Bearer ${AppConstants.newsApiKey}",
      };
      final result = await aDio.get(
        '${AppConstants.baseUrl}${AppConstants.topHeadlines}',
        options: Options(headers: headers),
        queryParameters: queryParams.toMap(),
      );

      if (result.statusCode == 200) {
        return TopHeadlinesResponse.fromMap(result.data);
      } else {
        throw Exception('Failed to load top headlines data from the server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
