import 'package:flutter/material.dart';
import '../screens/product_screen.dart';
import '../models/product_model.dart';
import '../controller/product_controller.dart';
import '../components/app_header.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ProductController _productController = ProductController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.nomeProduto;
      _valueController.text = widget.product!.precoProduto.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    super.dispose();
  }

void _saveProduct() async {
  if (_formKey.currentState!.validate()) {
    final product = Product(
      id: widget.product?.id ?? UniqueKey().toString(),
      nomeProduto: _nameController.text,
      precoProduto: double.tryParse(_valueController.text) ?? 0.0,
    );

    try {
      if (widget.product == null) {
        await _productController.addProduct(product);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produto adicionado com sucesso')),
        );
      } else {
        await _productController.updateProduct(product);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produto editado com sucesso')),
        );
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ProductScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao salvar o produto')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(showLoginButton: false, showReturnButton: true),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nome', style: TextStyle(fontSize: 16)),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(hintText: 'Nome do produto'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o nome do produto';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text('Valor', style: TextStyle(fontSize: 16)),
                      TextFormField(
                        controller: _valueController,
                        decoration: const InputDecoration(hintText: 'Valor do produto'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o valor do produto';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Insira um valor válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text('Imagem:', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 100, child: Center(child: Text('img'))),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _saveProduct,
                          child: Text(widget.product == null ? 'Adicionar' : 'Salvar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
