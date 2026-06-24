import 'package:cams/auth/services/auth_service.dart';
import 'package:cams/core/routes/app_routes.dart';
import 'package:cams/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final isLoading = false.obs;

  Future<void> login() async {
    try {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        Get.snackbar(
          'Error',
          'Email and password cannot be empty',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      isLoading.value = true;

      final response = await _authService.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final token = response['data']['token'];

      StorageService.saveToken(token);

      Get.offAllNamed(AppRoutes.dashboard);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
