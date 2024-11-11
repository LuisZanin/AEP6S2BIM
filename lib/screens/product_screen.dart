import 'package:flutter/material.dart';
import '../controller/product_controller.dart';
import '../models/product_model.dart';
import '../components/product_listview.dart';
import '../components/app_header.dart';
import '../service/product_service.dart';
import 'productForm_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductController _productController = ProductController();
  final ProductService _productService = ProductService();
  List<Product> products = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final fetchedProducts = await _productService.getProducts();
      setState(() {
        products = fetchedProducts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erro ao carregar produtos: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<void> deleteProduct(Product product) async {
    try {
      await _productController.removeProducts(product.id);
      setState(() {
        products.removeWhere((p) => p.id == product.id);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Produto excluído com sucesso'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao excluir produto'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void confirmDelete(Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: Text('Deseja excluir o produto ${product.nomeProduto}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteProduct(product);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  void _navigateToProductForm([Product? product]) async {
    final updatedProduct = await Navigator.push<Product>(
      context,
      MaterialPageRoute(
        builder: (context) => ProductFormScreen(product: product),
      ),
    );

    if (updatedProduct != null) {
      setState(() {
        if (product != null) {
          final index = products.indexWhere((p) => p.id == updatedProduct.id);
          if (index != -1) {
            products[index] = updatedProduct;
          }
        } else {
          products.add(updatedProduct);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(showLoginButton: false, showReturnButton: true,),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_error!, style: const TextStyle(color: Colors.red)),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _fetchProducts,
                                child: const Text('Tentar novamente'),
                              ),
                            ],
                          ),
                        )
                      : products.isEmpty
                          ? const Center(child: Text('Nenhum produto cadastrado'))
                          : ProductListView(
                              products: products,
                              onEditProduct: _navigateToProductForm,
                              onDeleteProduct: confirmDelete,
                            ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToProductForm(),
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
