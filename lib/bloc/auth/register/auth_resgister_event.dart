abstract class AuthRegisterEvent {}

class RegisterEvent extends AuthRegisterEvent {
  final String email;
  final String password;
  final String name;

  RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}
