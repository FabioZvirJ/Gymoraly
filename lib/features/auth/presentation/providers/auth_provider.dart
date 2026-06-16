import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../controllers/auth_controller.dart';
import '../../data/datasources/user_local_data_source.dart';
import '../../data/repositories/user_repository_impl.dart';

final authRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(UserLocalDataSourceImpl());
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterUseCase(repository);
});

final authControllerProvider = ChangeNotifierProvider<AuthController>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  final registerUseCase = ref.watch(registerUseCaseProvider);
  return AuthController(
    loginUseCase: loginUseCase,
    registerUseCase: registerUseCase,
  );
});
