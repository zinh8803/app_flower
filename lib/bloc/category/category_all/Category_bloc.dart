
import 'package:bloc/bloc.dart';
import 'package:frontend_flowershop/bloc/category/category_all/Category_event.dart';
import 'package:frontend_flowershop/bloc/category/category_all/Category_state.dart';
import 'package:frontend_flowershop/data/services/category/category_service.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ApiCategoryService apiService;

  CategoryBloc(this.apiService) : super(CategoryInitial()) {
    on<CategoryLoadEvent>((event, emit) async {
      emit(CategoryLoading());
      try {
        final categories = await apiService.getCategories();
        emit(CategoryLoaded(categories));
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
  }

}