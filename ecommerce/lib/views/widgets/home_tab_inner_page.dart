import 'package:ecommerce/view_models/home_tab_cubit/home_tab_cubit.dart';
import 'package:ecommerce/views/widgets/home_carousel_slider.dart';
import 'package:ecommerce/views/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTabInnerPage extends StatelessWidget {
  const HomeTabInnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final homeTabCubit = BlocProvider.of<HomeTabCubit>(context);

    return BlocBuilder<HomeTabCubit, HomeTabState>(
      bloc: homeTabCubit,
      buildWhen: (previous, current) =>
          current is HomeLoaded ||
          current is HomeLoading ||
          current is HomeError,
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is HomeLoaded) {
          final announcements = state.announcementsImages;
          final products = state.products;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.25,
                    child: HomeCarouselSlider(anouncements: announcements),
                  ),
                  const SizedBox(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'New Arrivals',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  GridView.builder(
                    itemCount: products.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: ProductItem(
                          productItem: products[index],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          );
        } else if (state is HomeError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
