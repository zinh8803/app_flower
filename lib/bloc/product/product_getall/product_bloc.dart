
import 'package:bloc/bloc.dart';
import 'package:frontend_flowershop/bloc/product/product_getall/product_event.dart';
import 'package:frontend_flowershop/bloc/product/product_getall/product_state.dart';
import 'package:frontend_flowershop/data/services/product/product_service.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService apiService;

  ProductBloc(this.apiService) : super(ProductInitial()) {
    on<ProductLoadEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await apiService.getProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }

}