import 'package:flutter/material.dart';
import 'package:food_delivery/models/product_model.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    debugPrint('FavoritesPage build()');

    if (favoritesProducts.isEmpty) {
      return const Center(
        child: Text('No Favorite Products!'),
      );
    }

    return ListView.builder(
        itemCount: favoritesProducts.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  
                },
                leading: Image.network(
                  favoritesProducts[index].imgUrl,
                  height: 100,
                  width: 70,
                  fit: BoxFit.fill,
                ),
                title: Text(
                  favoritesProducts[index].name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Text(
                  '${favoritesProducts[index].category.name} - \$${favoritesProducts[index].price}',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                ),
                trailing: orientation == Orientation.portrait ? IconButton(
                  onPressed: () {
                    setState(() {
                      favoritesProducts.remove(favoritesProducts[index]);
                    });
                  },
                  icon: const Icon(Icons.favorite),
                  color: Theme.of(context).primaryColor,
                ) : TextButton.icon(
                  onPressed: () {
                    setState(() {
                      favoritesProducts.remove(favoritesProducts[index]);
                    });
                  },
                  icon: const Icon(Icons.favorite),
                  label: const Text('Favorite'),
                ),
              ),
            ),
          );
        });
  }
}
