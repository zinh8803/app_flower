class Usermodel {
  final int user_id;
  final String username;
  final String email;
  final String password;
  final String? avatar;
  final String? phone_number;
  final String? address;
  final bool isAdmin;
  final String token;

  Usermodel({
    required this.user_id,
    required this.username,
    required this.email,
    required this.password,
    this.avatar,
    this.phone_number,
    this.address,
    required this.isAdmin,
    required this.token,
  });
  factory Usermodel.fromJson(Map<String, dynamic> json, String token) {
    return Usermodel(
      user_id: json['user_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      phone_number:
          json['phone_number'] == null ? '' : json['phone_number'].toString(),
      address: json['address'] == null ? '' : json['address'].toString(),
      avatar: json['avatar'],
      isAdmin: json['is_admin'],
      token: token,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'username': username,
      'email': email,
      'password': password,
      'phone_number': phone_number == null ? '' : phone_number.toString(),
      'address': address == null ? '' : address.toString(),
      'avatar': avatar,
      'is_admin': isAdmin,
      'token': token,
    };
  }
}
