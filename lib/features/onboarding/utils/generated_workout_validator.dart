import '../models/exercise_model.dart';
import '../models/generated_training_plan_model.dart';
import '../models/user_fitness_profile_model.dart';

class GeneratedWorkoutValidator {
  GeneratedTrainingPlanModel validate({
    required GeneratedTrainingPlanModel plan,
    required UserFitnessProfileModel profile,
  }) {
    if (plan.sessions.isEmpty) {
      return plan.copyWith(description: '${plan.description} Plano fallback seguro aplicado.');
    }

    final safeDivision = _safeDivision(plan.divisionType, profile);
    final maxExercises = profile.timePerWorkout == 'forty_five_minutes' ? 6 : 9;

    return plan.copyWith(
      divisionType: safeDivision,
      sessions: plan.sessions.map((session) {
        final exercises = session.exercises.take(maxExercises).map((exercise) {
          return ExerciseModel(
            id: exercise.id,
            name: exercise.name,
            sets: exercise.sets <= 0 ? 3 : exercise.sets,
            reps: exercise.reps.isEmpty ? '10-12' : exercise.reps,
            restSeconds: exercise.restSeconds <= 0 ? 90 : exercise.restSeconds,
            notes: _safeNotes(exercise, profile),
            muscleGroup: exercise.muscleGroup,
          );
        }).toList();

        return session.copyWith(exercises: exercises);
      }).toList(),
    );
  }

  String _safeDivision(String division, UserFitnessProfileModel profile) {
    final beginner = profile.alreadyTrainedStatus == 'never_trained' ||
        profile.selfDeclaredLevel == 'beginner' ||
        profile.selfDeclaredLevel == 'basic';
    if (beginner && (division == 'ABCDE' || division == 'PUSH_PULL_LEGS')) {
      return 'FULL_BODY';
    }
    if (profile.stoppedTrainingTime == 'more_than_one_year' && division == 'ABCDE') {
      return 'UPPER_LOWER';
    }
    return division;
  }

  String _safeNotes(ExerciseModel exercise, UserFitnessProfileModel profile) {
    final limitations = profile.limitations.join(' ').toLowerCase();
    if (limitations.contains('ombro') && exercise.name.toLowerCase().contains('desenvolvimento')) {
      return 'Use carga leve e amplitude confortável. Procure um profissional se houver dor.';
    }
    if (limitations.contains('joelho') && exercise.name.toLowerCase().contains('agachamento')) {
      return 'Priorize execução controlada e amplitude sem dor.';
    }
    if (exercise.notes.isNotEmpty) return exercise.notes;
    return 'Mantenha controle e técnica antes de aumentar carga.';
  }
}
