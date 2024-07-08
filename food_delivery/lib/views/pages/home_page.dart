import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/models/category_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/views/pages/product_details_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key}) {
    print('HomePage Constructor');
  }

  @override
  State<HomePage> createState() {
    print('HomePage Create State');
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String? selectedCategoryId;
  late List<ProductModel> filteredProducts;

  @override
  void initState() {
    super.initState();
    filteredProducts = dummyProducts;
    print('HomePage Init State');
  }

  @override
  Widget build(BuildContext context) {
    print('HomePage Build');
    final size = MediaQuery.of(context).size;
    final textScaler = MediaQuery.of(context).textScaler;
    final orientation = MediaQuery.of(context).orientation;
    var categoryTextScaler =
        textScaler.clamp(minScaleFactor: 0.1, maxScaleFactor: 2.0);
    var productNameTextScaler =
        textScaler.clamp(minScaleFactor: 0.1, maxScaleFactor: 1.5);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/home-banner.jpg',
                height:
                    size.height > 1000 ? size.height * 0.5 : size.height * 0.2,
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 36),
            SizedBox(
              height: size.width > 1000
                  ? size.height * 0.12
                  : orientation == Orientation.landscape
                      ? size.height * 0.3
                      : size.height * 0.15,
              child: ListView.builder(
                itemCount: dummyCategories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  final category = dummyCategories[index];

                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategoryId = category.id;
                          filteredProducts = dummyProducts
                              .where((product) =>
                                  product.category.id == selectedCategoryId)
                              .toList();
                        });
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: selectedCategoryId == category.id
                              ? AppColors.primary
                              : AppColors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                category.imgUrl,
                                height: 50,
                                width: 50,
                                color: selectedCategoryId == category.id
                                    ? AppColors.white
                                    : null,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                category.name,
                                textScaler: categoryTextScaler,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: selectedCategoryId == category.id
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 36),
            GridView.builder(
              itemCount: filteredProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size.width > 1200
                    ? 6
                    : size.width > 800
                        ? 4
                        : 2,
                mainAxisSpacing: 24,
                crossAxisSpacing: 16,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                final product = filteredProducts[index];

                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ProductDetailsPage.routeName,
                      arguments: product,
                    );
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(builder: (_) {
                    //     return ProductDetailsPage(
                    //       product: product,
                    //     );
                    //   }),
                    // );
                  },
                  child: LayoutBuilder(builder: (context, constraints) {
                    final maxHeight = constraints.maxHeight;
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(maxHeight * 0.01),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: product.imgUrl,
                                  height: maxHeight * 0.6,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: maxHeight * 0.01),
                                FittedBox(
                                  child: SizedBox(
                                    height: maxHeight * 0.18,
                                    child: Text(
                                      product.name,
                                      textScaler: productNameTextScaler,
                                      // maxLines: 1,
                                      // overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontSize: size.width > 1200
                                                ? size.aspectRatio * 20
                                                : size.aspectRatio * 30,
                                            fontWeight: FontWeight.w600,
                                          ),
                                      // style: const TextStyle(
                                      //   fontWeight: FontWeight.w600,
                                      //   fontSize: 16,
                                      // ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: maxHeight * 0.01),
                                SizedBox(
                                  height: maxHeight * 0.18,
                                  child: Text(
                                    '\$${product.price}',
                                    textScaler: productNameTextScaler,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                    // style: TextStyle(
                                    //   fontWeight: FontWeight.bold,
                                    //   color: Theme.of(context).primaryColor,
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.grey100,
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (favoritesProducts.contains(product)) {
                                      favoritesProducts.remove(product);
                                    } else {
                                      favoritesProducts.add(product);
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    favoritesProducts.contains(product)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 15,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
