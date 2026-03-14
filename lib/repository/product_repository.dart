import 'dart:async';

import 'package:ecom_mini/data/app_database.dart';
import 'package:ecom_mini/data/remote/product_api_service.dart';
import 'package:ecom_mini/model/product.dart';

class ProductRepository {
  ProductRepository(this._apiService, this._database, this._productDao);

  final ProductApiService _apiService;
  final AppDatabase _database;
  final ProductDao _productDao;

  Future<List<Product>> getRemoteProducts() async {
    return _apiService.fetchProducts();
  }

  Stream<List<Product>> watchLocalProducts() {
    return _productDao.watchProducts();
  }

  Future<void> saveLocalProducts(List<Product> products) async {
    await _productDao.saveProducts(products);
  }

  Future<void> close() async {
    await _database.close();
  }
}
