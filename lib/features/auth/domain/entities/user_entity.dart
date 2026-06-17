class UserEntity {
  final int? id;
  final String name;
  final String email;
  final String password;
  final int? age;
  final String? gender;
  final double? height;
  final double? weight;
  final int? trainingDaysPerWeek;
  final String? trainingGoal;

  const UserEntity({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.trainingDaysPerWeek,
    this.trainingGoal,
  });
}
