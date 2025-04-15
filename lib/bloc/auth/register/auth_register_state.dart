import 'package:equatable/equatable.dart';
import 'package:frontend_flowershop/data/models/user/UserModel.dart';

abstract class AuthRegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthRegisterInitial extends AuthRegisterState {}

class AuthRegisterLoading extends AuthRegisterState {}

class AuthRegisterSuccess extends AuthRegisterState {
  final Usermodel user;
  AuthRegisterSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class AuthRegisterFailure extends AuthRegisterState {
  final String error;

  AuthRegisterFailure(this.error);

  @override
  List<Object?> get props => [error];
}
