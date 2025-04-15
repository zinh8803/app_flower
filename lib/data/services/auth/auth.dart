import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_flowershop/data/models/user/UserModel.dart';
import 'package:frontend_flowershop/utils/constants.dart';

class ApiAuth {
  Future<Usermodel> login(String email, String password) async {
    final String url = "${Constants.baseUrl}/users/login";
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Usermodel.fromJson(jsonData['data'], jsonData['token']);
    } else {
      throw Exception('Đăng nhập thất bại: ${response.reasonPhrase}');
    }
  }

  Future<Usermodel> register(String name, String email, String password) async {
    final String url = "${Constants.baseUrl}/users/register";
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    print('Register response: ${response.statusCode}, ${response.body}');
    if (response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 201) {
        return Usermodel.fromJson(jsonData['data'], jsonData['token']);
      } else {
        throw Exception('Đăng ký thất bại: ${jsonData['message']}');
      }
    } else if (response.statusCode == 422) {
      final jsonData = jsonDecode(response.body);
      throw Exception('Email đã tồn tại: ${jsonData['message']}');
    } else {
      throw ('Email đã tồn tại');
    }
  }
}
