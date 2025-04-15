
abstract class ProductEvent {}

class ProductLoadEvent extends ProductEvent {
  final int productId;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final int stock;
  final int categoryId;

  ProductLoadEvent({
    required this.productId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.stock,
    required this.categoryId,
  });

}