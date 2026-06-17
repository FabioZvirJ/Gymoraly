import 'exercise_model.dart';

class TrainingSessionModel {
  const TrainingSessionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.muscleGroups,
    required this.estimatedDurationMinutes,
    required this.exercises,
  });

  final String id;
  final String title;
  final String subtitle;
  final List<String> muscleGroups;
  final int estimatedDurationMinutes;
  final List<ExerciseModel> exercises;

  TrainingSessionModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    List<String>? muscleGroups,
    int? estimatedDurationMinutes,
    List<ExerciseModel>? exercises,
  }) {
    return TrainingSessionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      muscleGroups: muscleGroups ?? this.muscleGroups,
      estimatedDurationMinutes: estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      exercises: exercises ?? this.exercises,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'muscleGroups': muscleGroups,
      'estimatedDurationMinutes': estimatedDurationMinutes,
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
    };
  }

  factory TrainingSessionModel.fromJson(Map<String, dynamic> json) {
    return TrainingSessionModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      muscleGroups: (json['muscleGroups'] as List<dynamic>? ?? []).cast<String>(),
      estimatedDurationMinutes: json['estimatedDurationMinutes'] as int? ?? 45,
      exercises: (json['exercises'] as List<dynamic>? ?? [])
          .map((item) => ExerciseModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
