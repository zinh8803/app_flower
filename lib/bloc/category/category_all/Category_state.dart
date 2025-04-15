
import 'package:equatable/equatable.dart';
import 'package:frontend_flowershop/data/models/category/CategoryModel.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Categorymodel> categories;

  CategoryLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);

  @override
  List<Object?> get props => [message];
}