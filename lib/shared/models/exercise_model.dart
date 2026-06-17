class ExerciseModel {
  const ExerciseModel({
    required this.id,
    required this.name,
    required this.sets,
    required this.reps,
    required this.rest,
    required this.muscleGroup,
  });

  final String id;
  final String name;
  final int sets;
  final String reps;
  final String rest;
  final String muscleGroup;
}
