import 'package:equatable/equatable.dart';
import 'package:frontend_flowershop/data/models/product/ProductModel.dart';

abstract class ProductidState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductidInitial extends ProductidState {}

class ProductidLoading extends ProductidState {}

class ProductLoaded extends ProductidState {
  final ProductModel productid;
  ProductLoaded(this.productid);
  @override
  List<Object?> get props => [productid];
}

class ProductidError extends ProductidState {
  final String message;

  ProductidError(this.message);

  @override
  List<Object?> get props => [message];
}
