import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cart_model.dart';

class CartService {
  final String baseUrl = 'http://10.0.2.2:3000';

  Future<List<CartItem>> getCartItems(String emailUsuario) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cart?emailUsuario=$emailUsuario'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => CartItem.fromJson(item)).toList();
      } else {
        throw Exception('Falha ao carregar itens do carrinho');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  Future<CartItem> addToCart({
    required String emailUsuario,
    required String nomeProduto,
    required double precoProduto,
    required String idProduto,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/cart'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'emailUsuario': emailUsuario,
          'nomeProduto': nomeProduto,
          'precoProduto': precoProduto,
          'idProduto': idProduto,
        }),
      );

      if (response.statusCode == 201) {
        return CartItem.fromJson(json.decode(response.body));
      } else {
        throw Exception('Falha ao adicionar item ao carrinho');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  Future<void> removeFromCart(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/cart/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Falha ao remover item do carrinho');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
}