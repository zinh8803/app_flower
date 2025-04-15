import 'dart:convert';

import 'package:frontend_flowershop/data/models/product/ProductModel.dart';
import 'package:frontend_flowershop/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.baseUrl}/products'),
      );
      print('Fetching products from: ${Constants.baseUrl}/products');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 200) {
          List<dynamic> data = jsonResponse['data'];
          return data.map((item) => ProductModel.fromJson(item)).toList();
        } else {
          throw Exception('API returned error: ${jsonResponse['message']}');
        }
      } else {
        throw Exception(
          'Failed to load products: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      print('Error fetching products: $e');
      rethrow;
    }
  }

  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.baseUrl}/products/$id'),
      );
      print('Fetching product from: ${Constants.baseUrl}/products/$id');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 200) {
          return ProductModel.fromJson(jsonResponse['data']);
        } else {
          throw Exception('API returned error: ${jsonResponse['message']}');
        }
      } else {
        throw Exception(
          'Failed to load product: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      print('Error fetching product: $e');
      rethrow;
    }
  }
}
