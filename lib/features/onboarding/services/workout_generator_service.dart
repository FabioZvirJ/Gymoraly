import '../models/generated_training_plan_model.dart';
import '../models/user_fitness_profile_model.dart';

abstract class WorkoutGeneratorService {
  Future<GeneratedTrainingPlanModel> generateWorkout(UserFitnessProfileModel profile);
}
