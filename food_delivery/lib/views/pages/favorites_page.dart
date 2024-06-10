import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/product_model.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({super.key}) {
    print('FavoritesPage Constructor');
  }

  @override
  Widget build(BuildContext context) {
    print('FavoritesPage Build');
    return Center(
      child: Text('Favorites Page - ${favoritesProducts.length}'),
    );
  }
}