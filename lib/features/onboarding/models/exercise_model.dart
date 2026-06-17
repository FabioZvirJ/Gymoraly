class ExerciseModel {
  const ExerciseModel({
    required this.id,
    required this.name,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    required this.notes,
    required this.muscleGroup,
  });

  final String id;
  final String name;
  final int sets;
  final String reps;
  final int restSeconds;
  final String notes;
  final String muscleGroup;

  ExerciseModel copyWith({
    String? id,
    String? name,
    int? sets,
    String? reps,
    int? restSeconds,
    String? notes,
    String? muscleGroup,
  }) {
    return ExerciseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      restSeconds: restSeconds ?? this.restSeconds,
      notes: notes ?? this.notes,
      muscleGroup: muscleGroup ?? this.muscleGroup,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sets': sets,
      'reps': reps,
      'restSeconds': restSeconds,
      'notes': notes,
      'muscleGroup': muscleGroup,
    };
  }

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      sets: json['sets'] as int? ?? 3,
      reps: json['reps'] as String? ?? '10-12',
      restSeconds: json['restSeconds'] as int? ?? 90,
      notes: json['notes'] as String? ?? '',
      muscleGroup: json['muscleGroup'] as String? ?? '',
    );
  }
}
