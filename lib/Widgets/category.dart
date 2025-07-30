// category_model.dart

class Category {
  final String name, image;

  Category({required this.name, required this.image});
}

List<Category> category = [
  Category(
    name: "Women",
    image: "assets/images _req/women.png",
  ),
  Category(
    name: "Men",
    image: "assets/images _req/men.png",
  ),
  Category(
    name: "Teens",
    image: "assets/images _req/teen.png",
  ),
  Category(
    name: "Kids",
    image: "assets/images _req/kid.png",
  ),
  Category(
    name: "Baby",
    image: "assets/images _req/baby.png",
  ),
];