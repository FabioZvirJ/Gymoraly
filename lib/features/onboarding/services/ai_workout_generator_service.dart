import '../models/generated_training_plan_model.dart';
import '../models/user_fitness_profile_model.dart';
import 'workout_generator_service.dart';

class AiWorkoutGeneratorService implements WorkoutGeneratorService {
  AiWorkoutGeneratorService({this.endpoint, this.apiKey});

  final String? endpoint;
  final String? apiKey;

  @override
  Future<GeneratedTrainingPlanModel> generateWorkout(UserFitnessProfileModel profile) {
    // TODO: conectar com backend/endpoint seguro para IA.
    // Não chame OpenAI direto no app com chave exposta. Use um backend seguro
    // para montar o prompt, autenticar, chamar a IA e retornar JSON validado.
    throw UnimplementedError('IA real ainda não conectada.');
  }
}
