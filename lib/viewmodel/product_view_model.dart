import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecom_mini/model/product.dart';
import 'package:ecom_mini/repository/product_repository.dart';
import 'package:flutter/foundation.dart';

class ProductViewModel extends ChangeNotifier {
  ProductViewModel(this._repository);

  final ProductRepository _repository;
  StreamSubscription<List<Product>>? _productsSubscription;

  final List<Product> _allProducts = [];
  List<Product> _visibleProducts = [];
  final Map<int, _CartLine> _cartLines = {};

  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';

  List<Product> get products => _visibleProducts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  bool get isCartEmpty => _cartLines.isEmpty;
  List<CartItem> get cartItems => _cartLines.values
      .map((line) => CartItem(product: line.product, quantity: line.quantity))
      .toList();
  int get totalCartUnits {
    var total = 0;
    for (final line in _cartLines.values) {
      total += line.quantity;
    }
    return total;
  }

  double get subtotal {
    var total = 0.0;
    for (final line in _cartLines.values) {
      total += line.product.price * line.quantity;
    }
    return total;
  }

  double get tax => subtotal * 0.12;
  double get grandTotal => subtotal + tax;

  Future<void> init() async {
    _productsSubscription ??= _repository.watchLocalProducts().listen((products) {
      _allProducts
        ..clear()
        ..addAll(products);
      _applyFilter(_searchQuery, notify: false);
      if (_errorMessage != null && products.isNotEmpty) {
        _errorMessage = null;
      }
      notifyListeners();
    });
    await loadProducts();
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final connectivityResults = await Connectivity().checkConnectivity();
    final hasNetwork = connectivityResults.any(
      (result) => result != ConnectivityResult.none,
    );

    if (!hasNetwork) {
      if (_allProducts.isEmpty) {
        _isLoading = false;
        _errorMessage = 'No internet connection. Please try again.';
        notifyListeners();
        return;
      }
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      final fetchedProducts = await _repository.getRemoteProducts();
      await _repository.saveLocalProducts(fetchedProducts);
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
    } catch (_) {
      if (_allProducts.isEmpty) {
        _isLoading = false;
        _errorMessage = 'Failed to load products. Please try again.';
        notifyListeners();
        return;
      }
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
    }
  }

  void search(String query) {
    _searchQuery = query;
    _applyFilter(query);
  }

  void addToCart(Product product) {
    final existing = _cartLines[product.id];
    if (existing == null) {
      _cartLines[product.id] = _CartLine(product: product, quantity: 1);
    } else {
      existing.quantity += 1;
    }
    notifyListeners();
  }

  void incrementCartItem(int productId) {
    final line = _cartLines[productId];
    if (line == null) {
      return;
    }
    line.quantity += 1;
    notifyListeners();
  }

  void decrementCartItem(int productId) {
    final line = _cartLines[productId];
    if (line == null) {
      return;
    }
    if (line.quantity == 1) {
      _cartLines.remove(productId);
    } else {
      line.quantity -= 1;
    }
    notifyListeners();
  }

  void clearCart() {
    _cartLines.clear();
    notifyListeners();
  }

  void _applyFilter(String query, {bool notify = true}) {
    final lowerQuery = query.trim().toLowerCase();
    if (lowerQuery.isEmpty) {
      _visibleProducts = List<Product>.from(_allProducts);
    } else {
      _visibleProducts = _allProducts
          .where((product) => product.title.toLowerCase().contains(lowerQuery))
          .toList();
    }

    if (notify) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _productsSubscription?.cancel();
    unawaited(_repository.close());
    super.dispose();
  }
}

class CartItem {
  CartItem({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  double get lineTotal => product.price * quantity;
}

class _CartLine {
  _CartLine({required this.product, required this.quantity});

  final Product product;
  int quantity;
}
