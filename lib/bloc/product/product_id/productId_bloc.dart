import 'package:bloc/bloc.dart';
import 'package:frontend_flowershop/bloc/product/product_id/productId_event.dart';
import 'package:frontend_flowershop/bloc/product/product_id/productId_state.dart';
import 'package:frontend_flowershop/data/services/product/product_service.dart';

class ProductidBloc extends Bloc<ProductIdEvent, ProductidState> {
  final ProductService apiService;
  ProductidBloc(this.apiService) : super(ProductidInitial()) {
    on<ProductIdLoadEvent>((event, emit) async {
      emit(ProductidLoading());
      try {
        final productId = await apiService.getProductById(event.productId);
        await Future.delayed(Duration(seconds: 2));
        emit(ProductLoaded(productId));
      } catch (e) {
        emit(ProductidError(e.toString()));
      }
    });
  }
}
