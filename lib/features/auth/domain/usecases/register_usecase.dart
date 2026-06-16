import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class RegisterUseCase implements UseCase<int, RegisterParams> {
  final UserRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<int> call(RegisterParams params) {
    return repository.registerUser(params.user);
  }
}

class RegisterParams {
  final UserEntity user;

  RegisterParams({required this.user});
}
