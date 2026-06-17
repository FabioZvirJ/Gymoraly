class UserFitnessProfileModel {
  const UserFitnessProfileModel({
    required this.id,
    this.name,
    this.alreadyTrainedStatus = 'never_trained',
    this.trainingTime = 'none',
    this.stoppedTrainingTime = 'none',
    this.selfDeclaredLevel = 'beginner',
    this.mainGoal = 'health',
    this.secondaryGoals = const [],
    this.weeklyTrainingDays = 3,
    this.timePerWorkout = 'one_hour',
    this.trainingLocation = 'full_gym',
    this.equipments = const [],
    this.age = 18,
    this.heightCm = 170,
    this.weightKg = 70,
    this.biologicalSex,
    this.activityLevel = 'lightly_active',
    this.limitations = const [],
    this.limitationDescription = '',
    this.dislikedExercises = '',
  });

  final String id;
  final String? name;
  final String alreadyTrainedStatus;
  final String trainingTime;
  final String stoppedTrainingTime;
  final String selfDeclaredLevel;
  final String mainGoal;
  final List<String> secondaryGoals;
  final int weeklyTrainingDays;
  final String timePerWorkout;
  final String trainingLocation;
  final List<String> equipments;
  final int age;
  final double heightCm;
  final double weightKg;
  final String? biologicalSex;
  final String activityLevel;
  final List<String> limitations;
  final String limitationDescription;
  final String dislikedExercises;

  bool get hasLimitations => limitations.any((item) => item != 'none');

  UserFitnessProfileModel copyWith({
    String? id,
    String? name,
    String? alreadyTrainedStatus,
    String? trainingTime,
    String? stoppedTrainingTime,
    String? selfDeclaredLevel,
    String? mainGoal,
    List<String>? secondaryGoals,
    int? weeklyTrainingDays,
    String? timePerWorkout,
    String? trainingLocation,
    List<String>? equipments,
    int? age,
    double? heightCm,
    double? weightKg,
    String? biologicalSex,
    String? activityLevel,
    List<String>? limitations,
    String? limitationDescription,
    String? dislikedExercises,
  }) {
    return UserFitnessProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      alreadyTrainedStatus: alreadyTrainedStatus ?? this.alreadyTrainedStatus,
      trainingTime: trainingTime ?? this.trainingTime,
      stoppedTrainingTime: stoppedTrainingTime ?? this.stoppedTrainingTime,
      selfDeclaredLevel: selfDeclaredLevel ?? this.selfDeclaredLevel,
      mainGoal: mainGoal ?? this.mainGoal,
      secondaryGoals: secondaryGoals ?? this.secondaryGoals,
      weeklyTrainingDays: weeklyTrainingDays ?? this.weeklyTrainingDays,
      timePerWorkout: timePerWorkout ?? this.timePerWorkout,
      trainingLocation: trainingLocation ?? this.trainingLocation,
      equipments: equipments ?? this.equipments,
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      biologicalSex: biologicalSex ?? this.biologicalSex,
      activityLevel: activityLevel ?? this.activityLevel,
      limitations: limitations ?? this.limitations,
      limitationDescription: limitationDescription ?? this.limitationDescription,
      dislikedExercises: dislikedExercises ?? this.dislikedExercises,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'alreadyTrainedStatus': alreadyTrainedStatus,
      'trainingTime': trainingTime,
      'stoppedTrainingTime': stoppedTrainingTime,
      'selfDeclaredLevel': selfDeclaredLevel,
      'mainGoal': mainGoal,
      'secondaryGoals': secondaryGoals,
      'weeklyTrainingDays': weeklyTrainingDays,
      'timePerWorkout': timePerWorkout,
      'trainingLocation': trainingLocation,
      'equipments': equipments,
      'age': age,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'biologicalSex': biologicalSex,
      'activityLevel': activityLevel,
      'limitations': limitations,
      'limitationDescription': limitationDescription,
      'dislikedExercises': dislikedExercises,
    };
  }

  factory UserFitnessProfileModel.fromJson(Map<String, dynamic> json) {
    return UserFitnessProfileModel(
      id: json['id'] as String? ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: json['name'] as String?,
      alreadyTrainedStatus: json['alreadyTrainedStatus'] as String? ?? 'never_trained',
      trainingTime: json['trainingTime'] as String? ?? 'none',
      stoppedTrainingTime: json['stoppedTrainingTime'] as String? ?? 'none',
      selfDeclaredLevel: json['selfDeclaredLevel'] as String? ?? 'beginner',
      mainGoal: json['mainGoal'] as String? ?? 'health',
      secondaryGoals: (json['secondaryGoals'] as List<dynamic>? ?? []).cast<String>(),
      weeklyTrainingDays: json['weeklyTrainingDays'] as int? ?? 3,
      timePerWorkout: json['timePerWorkout'] as String? ?? 'one_hour',
      trainingLocation: json['trainingLocation'] as String? ?? 'full_gym',
      equipments: (json['equipments'] as List<dynamic>? ?? []).cast<String>(),
      age: json['age'] as int? ?? 18,
      heightCm: (json['heightCm'] as num?)?.toDouble() ?? 170,
      weightKg: (json['weightKg'] as num?)?.toDouble() ?? 70,
      biologicalSex: json['biologicalSex'] as String?,
      activityLevel: json['activityLevel'] as String? ?? 'lightly_active',
      limitations: (json['limitations'] as List<dynamic>? ?? []).cast<String>(),
      limitationDescription: json['limitationDescription'] as String? ?? '',
      dislikedExercises: json['dislikedExercises'] as String? ?? '',
    );
  }
}
