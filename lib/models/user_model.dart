class User {
  final String id;
  final String email;
  final String senha;

  User({
    required this.id,
    required this.email,
    required this.senha,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      senha: json['senha'],
    );
  }
}