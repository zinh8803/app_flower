import 'dart:convert';
import 'dart:io';
import 'package:frontend_appflowershop/data/models/product.dart';
import 'package:frontend_appflowershop/utils/constants.dart';
import 'package:frontend_appflowershop/utils/preference_service.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiService_product {
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.baseUrl}/searching?name=$query'),
      );

      print('Searching products with query: $query');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 200) {
          List<dynamic> productsJson = jsonResponse['data'];
          return productsJson
              .map((json) => ProductModel.fromJson(json))
              .toList();
        } else {
          throw Exception('API returned error: ${jsonResponse['message']}');
        }
      } else {
        throw Exception(
            'Failed to search products: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error searching products: $e');
      rethrow;
    }
  }

  Future<List<ProductModel>> getProducts() async {
    final String url = "${Constants.baseUrl}${Constants.flowersEndpoint}";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        print(
            'ApiService_product: Fetching products from ${Constants.baseUrl}/products');
        print('ApiService_product: Response status: ${response.statusCode}');
        print('ApiService_product: Response body: ${response.body}');

        if (jsonResponse['status'] == 200) {
          return (jsonResponse['data'] as List)
              .map((item) => ProductModel.fromJson(item))
              .toList();
        } else {
          throw Exception("Lỗi API: ${jsonResponse['message']}");
        }
      } else {
        throw Exception("Lỗi kết nối: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Lỗi: $e");
    }
  }

  Future<ProductModel> getProductDetail(int productId) async {
    try {
      final response =
          await http.get(Uri.parse('${Constants.baseUrl}/products/$productId'));

      print(
          'Fetching product detail from: ${Constants.baseUrl}/products/$productId');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 200) {
          return ProductModel.fromJson(jsonResponse['data']);
        } else {
          throw Exception('API returned error: ${jsonResponse['message']}');
        }
      } else {
        throw Exception(
            'Failed to load product detail: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching product detail: $e');
      rethrow;
    }
  }

  Future<List<ProductModel>> getProductsByCategory(int categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.baseUrl}/products/category/$categoryId'),
      );

      print(
          'Fetching products by category from: ${Constants.baseUrl}/products/category/$categoryId');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 200) {
          List<dynamic> productsJson = jsonResponse['data'];
          return productsJson
              .map((json) => ProductModel.fromJson(json))
              .toList();
        } else {
          throw Exception('API returned error: ${jsonResponse['message']}');
        }
      } else {
        throw Exception(
            'Failed to load products by category: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching products by category: $e');
      rethrow;
    }
  }

  // Future<void> createProduct(ProductModel product, String imagePath) async {
  //   final token = await PreferenceService.getToken();
  //   if (token == null) {
  //     throw Exception('Token not found');
  //   }

  //   var uri = Uri.parse('${Constants.baseUrl}/products');
  //   var request = http.MultipartRequest('POST', uri);

  //   request.headers.addAll({
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   });

  //   request.fields.addAll({
  //     'name': product.name,
  //     'description': product.description!,
  //     'price': product.price.toString(),
  //     'stock': product.stock.toString(),
  //     'category_id': product.categoryId.toString(),
  //   });

  //   if (imagePath.isNotEmpty) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'image',
  //       imagePath,
  //       contentType: MediaType('image', 'jpeg'),
  //     ));
  //   }

  //   final streamedResponse = await request.send();
  //   final response = await http.Response.fromStream(streamedResponse);

  //   print('--- Response ---');
  //   print('Status code: ${response.statusCode}');
  //   print('Body: ${response.body}');

  //   if (response.statusCode != 200) {
  //     try {
  //       final json = jsonDecode(response.body);
  //       throw Exception(json['message'] ?? 'Unknown error occurred');
  //     } catch (e) {
  //       throw Exception('Error: ${response.body}');
  //     }
  //   }
  // }

  // Future<ProductModel> updateProduct({
  //   required int product_id,
  //   required String name,
  //   required String description,
  //   required double price,
  //   required int stock,
  //   required int categoryId,
  //   File? imageFile,
  //   String? imageUrl,
  // }) async {
  //   try {
  //     final token = await PreferenceService.getToken();
  //     if (token == null) {
  //       throw Exception('Token not found');
  //     }

  //     // Create multipart request for file upload if new image is provided
  //     if (imageFile != null) {
  //       var request = http.MultipartRequest(
  //         'PUT',
  //         Uri.parse('${Constants.baseUrl}/products/$product_id'),
  //       );

  //       // Add headers
  //       request.headers.addAll({
  //         'Authorization': 'Bearer $token',
  //       });

  //       // Add text fields
  //       request.fields['name'] = name;
  //       request.fields['description'] = description;
  //       request.fields['price'] = price.toString();
  //       request.fields['stock'] = stock.toString();
  //       request.fields['category_id'] = categoryId.toString();

  //       // Add image file
  //       var imageStream = http.ByteStream(imageFile.openRead());
  //       var imageLength = await imageFile.length();
  //       var multipartFile = http.MultipartFile(
  //         'image',
  //         imageStream,
  //         imageLength,
  //         filename: 'product_${DateTime.now().millisecondsSinceEpoch}.jpg',
  //       );
  //       request.files.add(multipartFile);

  //       print(
  //           'Updating product with image at: ${Constants.baseUrl}/products/$product_id');

  //       var response = await request.send();
  //       var responseString = await response.stream.bytesToString();

  //       print('Response status: ${response.statusCode}');
  //       print('Response body: $responseString');

  //       if (response.statusCode == 200) {
  //         Map<String, dynamic> jsonResponse = jsonDecode(responseString);
  //         if (jsonResponse['status'] == 200) {
  //           return ProductModel.fromJson(jsonResponse['data']);
  //         } else {
  //           throw Exception('API returned error: ${jsonResponse['message']}');
  //         }
  //       } else {
  //         throw Exception(
  //             'Failed to update product: ${response.statusCode} - $responseString');
  //       }
  //     } else {
  //       // Regular JSON request if no new image is provided
  //       final response = await http.put(
  //         Uri.parse('${Constants.baseUrl}/products/$product_id'),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //         body: jsonEncode({
  //           'name': name,
  //           'description': description,
  //           'price': price,
  //           'stock': stock,
  //           'category_id': categoryId,
  //           'image': imageUrl, // Pass existing image URL if available
  //         }),
  //       );

  //       print(
  //           'Updating product without image at: ${Constants.baseUrl}/products/$product_id');
  //       print('Response status: ${response.statusCode}');
  //       print('Response body: ${response.body}');

  //       if (response.statusCode == 200) {
  //         Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //         if (jsonResponse['status'] == 200) {
  //           return ProductModel.fromJson(jsonResponse['data']);
  //         } else {
  //           throw Exception('API returned error: ${jsonResponse['message']}');
  //         }
  //       } else {
  //         throw Exception(
  //             'Failed to update product: ${response.statusCode} - ${response.reasonPhrase}');
  //       }
  //     }
  //   } catch (e) {
  //     print('Error updating product: $e');
  //     rethrow;
  //   }
  // }

  Future<void> createProduct(ProductModel product, String imagePath) async {
    final token = await PreferenceService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    var uri = Uri.parse('${Constants.baseUrl}/products');
    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    request.fields.addAll({
      'name': product.name,
      'description': product.description!,
      'price': product.price.toString(),
      'stock': product.stock.toString(),
      'category_id': product.categoryId.toString(),
    });

    if (imagePath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imagePath,
        contentType: MediaType('image', 'jpeg'),
      ));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print('--- Response ---');
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode != 200) {
      try {
        final json = jsonDecode(response.body);
        throw Exception(json['message'] ?? 'Unknown error occurred');
      } catch (e) {
        throw Exception('Error: ${response.body}');
      }
    }
  }

  Future<void> updateProduct(ProductModel product, String imagePath) async {
    final token = await PreferenceService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    if (product.product_id == null) {
      throw Exception('Product ID is required for update');
    }

    var uri = Uri.parse('${Constants.baseUrl}/products/${product.product_id}');
    var request = http.MultipartRequest('PUT', uri);

    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    request.fields.addAll({
      'name': product.name,
      'description': product.description ?? '',
      'price': product.price.toString(),
      'stock': product.stock.toString(),
      'category_id': product.categoryId.toString(),
    });

    if (imagePath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imagePath,
        contentType: MediaType('image', 'jpeg'),
      ));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print('--- Update Response ---');
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode != 200 && response.statusCode != 201) {
      try {
        final json = jsonDecode(response.body);
        throw Exception(json['message'] ?? 'Unknown error occurred');
      } catch (e) {
        throw Exception('Error: ${response.body}');
      }
    }
  }

  Future<void> deleteProduct(int productId) async {
    final token = await PreferenceService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    var uri = Uri.parse(' ${Constants.baseUrl}/products/$productId');
    final response = await http.delete(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      try {
        final json = jsonDecode(response.body);
        throw Exception(json['message'] ?? 'Unknown error occurred');
      } catch (e) {
        throw Exception('Error: ${response.body}');
      }
    }
  }
}
