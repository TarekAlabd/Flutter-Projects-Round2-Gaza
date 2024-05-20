class CategoryModel {
  final String id;
  final String name;
  final String imgUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imgUrl,
  });
}

List<CategoryModel> dummyCategories = [
  CategoryModel(
    id: '1',
    name: 'Burger',
    imgUrl: 'assets/images/burger.png',
  ),
  CategoryModel(
    id: '2',
    name: 'Taco',
    imgUrl: 'assets/images/taco.png',
  ),
  CategoryModel(
    id: '3',
    name: 'Pizza',
    imgUrl: 'assets/images/pizza.png',
  ),
  CategoryModel(
    id: '4',
    name: 'Chicken',
    imgUrl: 'assets/images/chicken.png',
  ),
  CategoryModel(
    id: '5',
    name: 'Drinks',
    imgUrl: 'assets/images/soda.png',
  ),
];