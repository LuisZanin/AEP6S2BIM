import '../service/user_service.dart';

class RegisterController {
  final UserService _userService = UserService();

  Future<String?> registerUser(String email, String password) async {
    bool emailInUse = await _userService.isEmailInUse(email);
    if (emailInUse) {
      return "Email em Uso";
    }

    bool success = await _userService.createUser(email, password);
    if (success) {
      return "Certinho";
    } else {
      return "Erro ao criar usuário";
    }
  }
}
