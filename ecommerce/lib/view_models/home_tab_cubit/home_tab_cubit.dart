import 'package:ecommerce/models/product_item_model.dart';
import 'package:ecommerce/services/auth_services.dart';
import 'package:ecommerce/services/favorite_services.dart';
import 'package:ecommerce/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_tab_state.dart';

class HomeTabCubit extends Cubit<HomeTabState> {
  HomeTabCubit() : super(HomeInitial());

  final homeServices = HomeServices();
  final favoriteServices = FavoriteServices();
  final authServices = AuthServices();

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      final products = await homeServices.getProducts();
      final currentUser = authServices.currentUser;
      final favProducts = await favoriteServices.getFavoriteItems(currentUser!.uid);

      for (var product in products) {
        if (favProducts.any((element) => element.id == product.id)){
          final index = products.indexOf(product);
          product = product.copyWith(isFavorite: true);
          products[index] = product;
        } else {
          product = product.copyWith(isFavorite: false);
        }
      }

      emit(
        HomeLoaded(
          announcementsImages: imgList,
          products: products,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> toggleFavorite(ProductItemModel productItem) async {
    emit(SetFavoriteLoading(productItem.id));
    try {
      final currentUser = authServices.currentUser;
      final favProducts = await favoriteServices.getFavoriteItems(currentUser!.uid);

      if (favProducts.any((element) => element.id == productItem.id)){
        await favoriteServices.removeFavorite(currentUser.uid, productItem.id);
        emit(SetFavoriteSuccess(
          favoritedId: productItem.id, isFavorite: false));
      } else {
        await favoriteServices.addFavorite(currentUser.uid, productItem);
        emit(SetFavoriteSuccess(
          favoritedId: productItem.id, isFavorite: true));
      }
    } catch (e) {
      emit(SetFavoriteError(e.toString()));
    }
  }
}
