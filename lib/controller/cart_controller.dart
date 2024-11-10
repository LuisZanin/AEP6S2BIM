import '../models/cart_model.dart';
import '../service/cart_service.dart';

class CartController {
  final CartService _cartService = CartService();
  List<CartItem> items = [];
  bool isLoading = false;
  String? error;
  
  double get total => items.fold(0, (sum, item) => sum + item.precoProduto);

  Future<void> loadCartItems(String emailUsuario) async {
    try {
      isLoading = true;
      error = null;

      items = await _cartService.getCartItems(emailUsuario);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> addToCart({
    required String emailUsuario,
    required String nomeProduto,
    required double precoProduto,
    required String idProduto,
  }) async {
    try {
      error = null;
      final newItem = await _cartService.addToCart(
        emailUsuario: emailUsuario,
        nomeProduto: nomeProduto,
        precoProduto: precoProduto,
        idProduto: idProduto,
      );
      
      items.add(newItem);
    } catch (e) {
      error = e.toString();
      rethrow;
    }
  }

  Future<void> removeFromCart(String id) async {
    try {
      error = null;
      await _cartService.removeFromCart(id);
      items.removeWhere((item) => item.id == id);
    } catch (e) {
      error = e.toString();
      rethrow;
    }
  }
}