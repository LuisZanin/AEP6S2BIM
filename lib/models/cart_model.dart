class CartItem {
  final String id;
  final String emailUsuario;
  final String nomeProduto;
  final double precoProduto;
  final String idProduto;

  CartItem({
    required this.id,
    required this.emailUsuario,
    required this.nomeProduto,
    required this.precoProduto,
    required this.idProduto,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      emailUsuario: json['emailUsuario'],
      nomeProduto: json['nomeProduto'],
      precoProduto: (json['precoProduto'] as num).toDouble(),
      idProduto: json['idProduto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emailUsuario': emailUsuario,
      'nomeProduto': nomeProduto,
      'precoProduto': precoProduto,
      'idProduto': idProduto,
    };
  }
}