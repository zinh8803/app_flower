import 'package:bloc/bloc.dart';
import 'package:frontend_flowershop/bloc/auth/register/auth_register_state.dart';
import 'package:frontend_flowershop/bloc/auth/register/auth_resgister_event.dart';
import 'package:frontend_flowershop/data/services/auth/auth.dart';

class AuthRegisterBloc extends Bloc<AuthRegisterEvent, AuthRegisterState> {
  final ApiAuth api;

  AuthRegisterBloc(this.api) : super(AuthRegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      emit(AuthRegisterLoading());
      try {
        final user = await api.register(
          event.name,
          event.email,
          event.password,
        );
        emit(AuthRegisterSuccess(user));
      } catch (error) {
        emit(AuthRegisterFailure(error.toString()));
      }
    });
  }
}
