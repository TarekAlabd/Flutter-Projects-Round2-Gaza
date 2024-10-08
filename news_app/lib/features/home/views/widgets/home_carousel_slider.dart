import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/home/models/top_headlines_response.dart';

class HomeCarouselSlider extends StatelessWidget {
  final List<Article> topHeadlines;
  const HomeCarouselSlider({
    super.key,
    required this.topHeadlines,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200),
      child: topHeadlines.isNotEmpty
          ? CarouselView(
              itemExtent: 330,
              shrinkExtent: 200,
              children: List<Widget>.generate(topHeadlines.length, (int index) {
                final topHeadline = topHeadlines[index];

                return Container(
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          topHeadline.urlToImage ?? ''),
                      onError: (exception, stackTrace) => CachedNetworkImage(
                          imageUrl:
                              'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                      right: 16,
                      left: 16,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        topHeadline.title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                );
              }),
            )
          : const Text('No Data!'),
    );
  }
}
