import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductService {
  final String baseUrl = 'http://10.0.2.2:3000';

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Falha ao carregar produtos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/products'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nomeProduto': product.nomeProduto,
          'precoProduto': product.precoProduto,
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Falha ao adicionar produto');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/products/${product.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nomeProduto': product.nomeProduto,
          'precoProduto': product.precoProduto,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Falha ao atualizar produto');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  Future<void> removeProduct(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/products/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Falha ao remover item do carrinho');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
}
