import '../../../../core/utils/input_validator.dart';

class AuthFormModel {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  int age = 0;
  String gender = '';
  double height = 0.0;
  double weight = 0.0;
  int trainingDaysPerWeek = 3;
  String trainingGoal = 'Hipertrofia';

  bool get isLoginValid =>
      InputValidator.isValidEmail(email) && password.length >= 6;

  bool get isRegisterStep1Valid =>
      name.isNotEmpty &&
      InputValidator.isValidEmail(email) &&
      password.length >= 6 &&
      password == confirmPassword;
}
