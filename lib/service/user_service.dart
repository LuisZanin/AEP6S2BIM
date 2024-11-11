import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserService {
  final String baseUrl = 'http://10.0.2.2:3000';
  static String loggedUserEmail = "";

  Future<bool> authenticateUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/users?email=$email&senha=$password');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> users = json.decode(response.body);
        loggedUserEmail = email.toLowerCase();
        
        return users.length == 1;
      } else {
        print('Erro ao buscar usuário: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erro na requisição: $e');
      return false;
    }
  }

  Future<User> createUser({
    required String email,
    required String password,
    }) async {
    final url = Uri.parse('$baseUrl/users');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": email,
          "senha": password,
        }),
      );

      if (response.statusCode == 201) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Erro ao criar usuário: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  Future<bool> isEmailInUse(String email) async {
    final url = Uri.parse('$baseUrl/users?email=$email');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> users = json.decode(response.body);

        return users.isNotEmpty;
      } else {
        print('Erro ao verificar email: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erro na requisição: $e');
      return false;
    }
  }
}
