class ProductModel {
  final int product_id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String image;
  final int category_id;
 
 ProductModel({
    required this.product_id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.category_id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      product_id: json['product_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      stock: json['stock'],
      image: json['image'],
      category_id: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': product_id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'image': image,
      'category_id': category_id,
    };
  }
 }

