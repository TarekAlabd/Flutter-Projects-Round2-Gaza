import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/models/product_item_model.dart';
import 'package:ecommerce/utils/app_colors.dart';
import 'package:ecommerce/view_models/home_tab_cubit/home_tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatefulWidget {
  final ProductItemModel productItem;
  const ProductItem({super.key, required this.productItem});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final homeTabCubit = BlocProvider.of<HomeTabCubit>(context);

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 130,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: AppColors.grey2,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: widget.productItem.imgUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white54,
                ),
                child: InkWell(
                  onTap: () => homeTabCubit.toggleFavorite(widget.productItem),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: BlocBuilder<HomeTabCubit, HomeTabState>(
                      bloc: homeTabCubit,
                      buildWhen: (previous, current) =>
                          (current is SetFavoriteLoading && current.favoritedId == widget.productItem.id) ||
                          (current is SetFavoriteSuccess && current.favoritedId == widget.productItem.id) ||
                          current is SetFavoriteError,
                      builder: (context, state) {
                        if (state is SetFavoriteLoading) {
                          return const CircularProgressIndicator.adaptive();
                        } else if (state is SetFavoriteSuccess) {
                          return Icon(
                            state.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 20,
                            color: Theme.of(context).primaryColor,
                          );
                        }
                        return Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          widget.productItem.name,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          widget.productItem.category,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.grey,
              ),
        ),
        Text(
          '\$${widget.productItem.price}',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
