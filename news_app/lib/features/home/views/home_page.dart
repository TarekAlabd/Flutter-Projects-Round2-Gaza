import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/widgets/app_drawer.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/views/widgets/home_carousel_slider.dart';
import 'package:news_app/features/home/views/widgets/home_list_news.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('News'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Top in Tech',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<HomeCubit, HomeState>(
                bloc: homeCubit,
                buildWhen: (previous, current) =>
                    current is HomeCarouselLoaded ||
                    current is HomeCarouselError ||
                    current is HomeCarouselLoading,
                builder: (context, state) {
                  if (state is HomeCarouselLoaded) {
                    final topHeadlines = state.topHeadlines;

                    return HomeCarouselSlider(topHeadlines: topHeadlines);
                  } else if (state is HomeCarouselLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is HomeCarouselError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Top News!',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<HomeCubit, HomeState>(
                bloc: homeCubit,
                buildWhen: (previous, current) =>
                    current is HomeListLoaded ||
                    current is HomeListError ||
                    current is HomeListLoading,
                builder: (context, state) {
                  if (state is HomeListLoaded) {
                    final topHeadlines = state.topHeadlines;

                    return HomeListNews(articles: topHeadlines);
                  } else if (state is HomeListLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is HomeListError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
