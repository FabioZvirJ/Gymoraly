import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../models/auth_form_model.dart';

class AuthController extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthController({required this.loginUseCase, required this.registerUseCase});

  final AuthFormModel model = AuthFormModel();

  bool isPasswordVisible = false;
  bool isLoading = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  Future<UserEntity?> login() async {
    isLoading = true;
    notifyListeners();

    try {
      final user = await loginUseCase(
        LoginParams(email: model.email, password: model.password),
      );
      return user;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<int> register() async {
    isLoading = true;
    notifyListeners();

    final user = UserEntity(
      name: model.name,
      email: model.email,
      password: model.password,
      age: model.age,
      gender: model.gender,
      height: model.height,
      weight: model.weight,
      trainingDaysPerWeek: model.trainingDaysPerWeek,
      trainingGoal: model.trainingGoal,
    );

    try {
      return await registerUseCase(RegisterParams(user: user));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
