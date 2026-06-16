import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class LoginUseCase implements UseCase<UserEntity?, LoginParams> {
  final UserRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<UserEntity?> call(LoginParams params) {
    return repository.loginUser(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
