import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,

          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  const Text(
                    'Campus Accommodation',
                    style: TextStyle(fontSize: 24),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: controller.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Obx(() {
                    return ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.login,

                      child: controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text('Login'),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
