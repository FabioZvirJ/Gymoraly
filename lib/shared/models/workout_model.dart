import 'exercise_model.dart';

class WorkoutModel {
  const WorkoutModel({
    required this.id,
    required this.title,
    required this.durationMinutes,
    required this.level,
    required this.exercises,
  });

  final String id;
  final String title;
  final int durationMinutes;
  final String level;
  final List<ExerciseModel> exercises;
}
