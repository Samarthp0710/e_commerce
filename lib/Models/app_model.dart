class AppModel {
  final String image;
  final String title;
  final String price;

  AppModel({
    required this.image,
    required this.title,
    required this.price,
  });
}

// Dummy data for now
List<AppModel> fashionEcommerceApp = [
  AppModel(
    image: 'assets/images_req/item1.png',
    title: 'Stylish Jacket',
    price: '₹1299',
  ),
  AppModel(
    image: 'assets/images_req/item2.png',
    title: 'Summer Dress',
    price: '₹999',
  ),
  AppModel(
    image: 'assets/images_req/item3.png',
    title: 'Casual Shoes',
    price: '₹1599',
  ),
];
