import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../service/product_service.dart';

class ProductController extends ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProducts() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _products = await _productService.getProducts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      _error = null;
      await _productService.addProduct(product);
      _products.add(product);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      _error = null;
      await _productService.updateProduct(product);
      final index = _products.indexWhere((item) => item.id == product.id);
      if (index != -1) {
        _products[index] = product;
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  Future<void> removeProducts(String id) async {
    try {
      _error = null;
      await _productService.removeProduct(id);
      _products.removeWhere((item) => item.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }
}
