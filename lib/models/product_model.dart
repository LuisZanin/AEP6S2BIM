class Product {
  final String id;
  final String nomeProduto;
  final double precoProduto;

  Product({
    required this.id,
    required this.nomeProduto,
    required this.precoProduto,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nomeProduto: json['nomeProduto'],
      precoProduto: double.parse(json['precoProduto'].toString()),
    );
  }
}