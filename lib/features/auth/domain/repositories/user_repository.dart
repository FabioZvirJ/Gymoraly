import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<int> registerUser(UserEntity user);
  Future<UserEntity?> loginUser(String email, String password);
}
