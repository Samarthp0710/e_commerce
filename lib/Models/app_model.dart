class AppModel {
  final String image;
  final String title;
  final String price;

  var isCheck;

  AppModel({
    required this.image,
    required this.title,
    required this.price,
  });
}

// Dummy data for now
List<AppModel> fashionEcommerceApp = [
  AppModel(
    image: 'assets/images _req/jacket.png',
    title: 'Stylish Jacket',
    price: '₹1299',
  ),
  AppModel(
    image: 'assets/images _req/kurtas.png',
    title: 'Kurtas',
    price: '₹999',
  ),
  AppModel(
    image: 'assets/images _req/shoes.png',
    title: 'Casual Shoes',
    price: '₹1599',
  ),
  AppModel(
    image: 'assets/images _req/jeans.png',
    title: 'Jeans',
    price: '₹799',
  ),
];
