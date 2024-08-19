import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/utils/app_colors.dart';
import 'package:ecommerce/view_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/views/pages/cart_page.dart';
import 'package:ecommerce/views/pages/favorite_page.dart';
import 'package:ecommerce/views/pages/home_page.dart';
import 'package:ecommerce/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              'https://yt3.googleusercontent.com/ytc/AIdro_nGmcgNuWCHFJ2SnkZCNWUwRaqc_iuEKMOtvtO49AA_iuc=s900-c-k-c0x00ffffff-no-rj',
            ),
          ),
        ),
        centerTitle: false,
        title: _buildTitle(),
        actions: [
          if (_currentIndex == 0)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: PersistentTabView(
        onTabChanged: (value) => setState(() {
          _currentIndex = value;
        }),
        tabs: [
          PersistentTabConfig(
            screen: const HomePage(),
            item: ItemConfig(
              icon: const Icon(Icons.home),
              title: "Home",
              activeForegroundColor: AppColors.primary,
              inactiveForegroundColor: AppColors.grey4,
            ),
          ),
          PersistentTabConfig(
            screen: BlocProvider(
              create: (context) {
                final cubit = CartCubit();
                cubit.getCartItems();
                return cubit;
              },
              child: const CartPage(),
            ),
            item: ItemConfig(
              icon: const Icon(Icons.shopping_cart),
              title: "Cart",
              activeForegroundColor: AppColors.primary,
              inactiveForegroundColor: AppColors.grey4,
            ),
          ),
          PersistentTabConfig(
            screen: const FavoritePage(),
            item: ItemConfig(
              icon: const Icon(Icons.favorite),
              title: "Favorite",
              activeForegroundColor: AppColors.primary,
              inactiveForegroundColor: AppColors.grey4,
            ),
          ),
          PersistentTabConfig(
            screen: const ProfilePage(),
            item: ItemConfig(
              icon: const Icon(Icons.person),
              title: "Profile",
              activeForegroundColor: AppColors.primary,
              inactiveForegroundColor: AppColors.grey4,
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarConfig: navBarConfig,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    switch (_currentIndex) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Tarek',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              'Let\'s go shopping!',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ],
        );
      case 1:
        return const Text('Cart');
      case 2:
        return const Text('Favorite');
      case 3:
        return const Text('Profile');
      default:
        return const Text('Home');
    }
  }
}
