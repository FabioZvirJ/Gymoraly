import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl(this.localDataSource);

  @override
  Future<int> registerUser(UserEntity user) async {
    final userModel = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      password: user.password,
      age: user.age,
      gender: user.gender,
      height: user.height,
      weight: user.weight,
      trainingDaysPerWeek: user.trainingDaysPerWeek,
      trainingGoal: user.trainingGoal,
    );
    return localDataSource.registerUser(userModel);
  }

  @override
  Future<UserEntity?> loginUser(String email, String password) async {
    final userModel = await localDataSource.loginUser(email, password);
    return userModel;
  }
}
