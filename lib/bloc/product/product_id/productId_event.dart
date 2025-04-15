abstract class ProductIdEvent {}

class ProductIdLoadEvent extends ProductIdEvent {
  final int productId;

  ProductIdLoadEvent({required this.productId});
}
