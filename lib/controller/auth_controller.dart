import '../service/user_service.dart';

class AuthController {
  final UserService _userService = UserService();

  Future<bool> login(String email, String password) async {
    return await _userService.authenticateUser(email, password);
  }
}
