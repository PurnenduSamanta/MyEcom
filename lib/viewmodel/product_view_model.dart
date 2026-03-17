import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecom_mini/model/product.dart';
import 'package:ecom_mini/repository/product_repository.dart';
import 'package:flutter/foundation.dart';

class ProductViewModel extends ChangeNotifier {
  ProductViewModel(this._repository);

  static const String allCategory = "All";

  final ProductRepository _repository;
  StreamSubscription<List<Product>>? _productsSubscription;

  final List<Product> _products = [];
  final Map<int, CartItem> _cartLines = {};
  String _selectedProductCategory = allCategory;
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  bool get isCartEmpty => _cartLines.isEmpty;
  List<CartItem> get cartItems => _cartLines.values.toList(growable: false);
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

  String get selectedProductCategory => _selectedProductCategory;

  List<String> get categories {
    List<String> categories = [];
    categories.add(allCategory);
    _products.forEach((product) {
      if (!categories.contains(product.category)) {
        categories.add(product.category);
      }
    });
    return categories;
  }

  List<Product> get products {
    final lowerQuery = _searchQuery.trim().toLowerCase();
    return _products.where((product) {
      bool matchedSearch =
          (searchQuery.isEmpty ||
          product.title.toLowerCase().contains(lowerQuery));
      bool matchedCategory =
          (_selectedProductCategory == allCategory ||
          product.category == _selectedProductCategory);
      return matchedSearch && matchedCategory;
    }).toList();
  }

  Future<void> init() async {
    _productsSubscription ??= _repository.watchLocalProducts().listen((
      products,
    ) {
      _products
        ..clear()
        ..addAll(products);
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

    if (!await hasNetwork()) {
      if (_products.isEmpty) {
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
      if (_products.isEmpty) {
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
    final normalizedQuery = query.trim();
    if (_searchQuery == normalizedQuery) {
      return;
    }
    _searchQuery = normalizedQuery;
    notifyListeners();
  }

  void setCategory(String category) {
    if (selectedProductCategory == category) {
      return;
    }
    _selectedProductCategory = category;
    notifyListeners();
  }

  void addToCart(Product product) {
    final existing = _cartLines[product.id];
    if (existing == null) {
      _cartLines[product.id] = CartItem(product: product, quantity: 1);
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

  @override
  void dispose() {
    _productsSubscription?.cancel();
    unawaited(_repository.close());
    super.dispose();
  }

  Future<bool> hasNetwork() async {
    final connectivityResults = await Connectivity().checkConnectivity();
    return connectivityResults.any(
      (result) => result != ConnectivityResult.none,
    );
  }
}

class CartItem {
  CartItem({required this.product, required this.quantity});

  final Product product;
  int quantity;

  double get lineTotal => product.price * quantity;
}
