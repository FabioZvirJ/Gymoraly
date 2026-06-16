import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    int? id,
    required String name,
    required String email,
    required String password,
    int? age,
    String? gender,
    double? height,
    double? weight,
  }) : super(
          id: id,
          name: name,
          email: email,
          password: password,
          age: age,
          gender: gender,
          height: height,
          weight: weight,
        );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    double? parseNullableDouble(dynamic value) {
      if (value == null) return null;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      return double.tryParse(value.toString());
    }

    return UserModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      age: map['age'] as int?,
      gender: map['gender'] as String?,
      height: parseNullableDouble(map['height']),
      weight: parseNullableDouble(map['weight']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
    };
  }
}
