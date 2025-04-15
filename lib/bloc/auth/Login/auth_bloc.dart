import 'package:bloc/bloc.dart';

import 'package:frontend_flowershop/bloc/auth/Login/auth_event.dart';
import 'package:frontend_flowershop/bloc/auth/Login/auth_state.dart';
import 'package:frontend_flowershop/data/services/auth/auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiAuth api;

  AuthBloc(this.api) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await api.login(event.email, event.password);
        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
