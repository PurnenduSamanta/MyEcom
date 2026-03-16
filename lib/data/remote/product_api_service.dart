import 'package:dio/dio.dart';
import 'package:ecom_mini/model/product.dart';

class ProductApiService {
  static const String _baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    final dio = Dio();
    final Response<dynamic> response = await dio.get(_baseUrl);

    if (response.statusCode != 200) {
      throw Exception('Failed to load products');
    }

    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
