import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/models/top_headlines_response.dart';

class HomeListNews extends StatelessWidget {
  final List<Article> articles;
  const HomeListNews({
    super.key,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 6),
      itemBuilder: (_, index) {
        return Card(
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: articles[index].urlToImage ?? '',
                fit: BoxFit.cover,
                height: 80,
                width: 80,
                errorWidget: (context, url, error) => CachedNetworkImage(
                  imageUrl:
                      'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
                ),
              ),
            ),
            title: Text(
              articles[index].title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            subtitle: Text(
              articles[index].description ?? articles[index].content ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.grey,
                  ),
            ),
            trailing: BlocBuilder<HomeCubit, HomeState>(
              bloc: homeCubit,
              buildWhen: (previous, current) =>
                  (current is HomeFavoriteLoaded && current.title == articles[index].title) ||
                  current is HomeFavoriteError ||
                  (current is HomeFavoriteLoading && current.title == articles[index].title),
              builder: (context, state) {
                if (state is HomeFavoriteLoading) {
                  return const CircularProgressIndicator.adaptive();
                } else if (state is HomeFavoriteLoaded) {
                  return IconButton(
                    onPressed: () async {
                      await homeCubit.setFavorite(articles[index]);
                    },
                    icon: Icon(
                      state.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: state.isFavorite ? AppColors.red : null,
                    ),
                  );
                } else {
                  return IconButton(
                    onPressed: () async {
                      await homeCubit.setFavorite(articles[index]);
                    },
                    icon: Icon(
                      articles[index].isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: articles[index].isFavorite ? AppColors.red : null,
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
      itemCount: articles.length,
    );
  }
}
