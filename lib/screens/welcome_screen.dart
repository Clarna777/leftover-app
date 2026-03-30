import 'package:flutter/material.dart';
import '../widgets/rounded_primary_button.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                'Leftover Recipes',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              const Text(
                'Find simple recipes from ingredients you already have.',
              ),
              const Spacer(),
              RoundedPrimaryButton(
                label: 'Login',
                onPressed: () => Navigator.pushNamed(
                  context,
                  LoginScreen.routeName,
                ),
              ),
              const SizedBox(height: 12),
              RoundedPrimaryButton(
                label: 'Register',
                onPressed: () => Navigator.pushNamed(
                  context,
                  RegisterScreen.routeName,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
