import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

class AppHeader extends StatelessWidget {
  final bool showLoginButton;
  final bool showReturnButton;

  const AppHeader({
    super.key,
    this.showLoginButton = true,
    this.showReturnButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          if (showReturnButton)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                if (context.widget is! HomeScreen) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                }
              },
              child: const Text(
                'Snks',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (showLoginButton)
            Positioned(
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(), // Padding inferior
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 33,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: const Icon(Icons.person, color: Colors.black),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
