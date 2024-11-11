import '../service/user_service.dart';

class RegisterController {
  final UserService _userService;

  RegisterController({UserService? userService}) 
    : _userService = userService ?? UserService();

  Future<Object?> registerUser(String email, String password) async {
    bool emailInUse = await _userService.isEmailInUse(email);
    if (emailInUse) {
      return false;
    }

    final response = await _userService.createUser(email: email, password: password);
    if (response.id.isNotEmpty) {
      return true;
    } else {
      return null;
    }
  }
}
