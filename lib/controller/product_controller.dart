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
}
