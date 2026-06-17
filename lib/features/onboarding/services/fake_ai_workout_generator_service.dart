import '../models/exercise_model.dart';
import '../models/generated_training_plan_model.dart';
import '../models/training_session_model.dart';
import '../models/user_fitness_profile_model.dart';
import '../utils/generated_workout_validator.dart';
import '../utils/workout_division_recommender.dart';
import 'workout_generator_service.dart';

class FakeAiWorkoutGeneratorService implements WorkoutGeneratorService {
  FakeAiWorkoutGeneratorService({
    WorkoutDivisionRecommender? recommender,
    GeneratedWorkoutValidator? validator,
  }) : recommender = recommender ?? WorkoutDivisionRecommender(),
       validator = validator ?? GeneratedWorkoutValidator();

  final WorkoutDivisionRecommender recommender;
  final GeneratedWorkoutValidator validator;

  @override
  Future<GeneratedTrainingPlanModel> generateWorkout(UserFitnessProfileModel profile) async {
    await Future.delayed(const Duration(seconds: 2));

    final division = recommender.recommendDivision(profile);
    final plan = GeneratedTrainingPlanModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Treino personalizado ${_divisionLabel(division)}',
      description: _descriptionFor(profile, division),
      divisionType: division,
      level: _levelLabel(profile),
      goal: _goalLabel(profile.mainGoal),
      weeklyFrequency: '${profile.weeklyTrainingDays}x por semana',
      estimatedDuration: '${_durationMinutes(profile)} minutos por sessão',
      aiExplanation: _explanationFor(profile, division),
      sessions: _sessionsFor(division, profile),
    );

    return validator.validate(plan: plan, profile: profile);
  }

  GeneratedTrainingPlanModel generateFallback(UserFitnessProfileModel profile) {
    final safeProfile = profile.copyWith(
      selfDeclaredLevel: 'beginner',
      weeklyTrainingDays: profile.weeklyTrainingDays < 2 ? 2 : profile.weeklyTrainingDays,
    );
    final plan = GeneratedTrainingPlanModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Treino básico seguro',
      description: 'Plano local de adaptação com exercícios simples e volume controlado.',
      divisionType: 'FULL_BODY',
      level: 'Iniciante',
      goal: _goalLabel(profile.mainGoal),
      weeklyFrequency: '${safeProfile.weeklyTrainingDays}x por semana',
      estimatedDuration: '45 minutos por sessão',
      aiExplanation: 'Geramos um treino básico local porque a IA não pôde responder agora.',
      sessions: _sessionsFor('FULL_BODY', safeProfile),
    );
    return validator.validate(plan: plan, profile: safeProfile);
  }

  List<TrainingSessionModel> _sessionsFor(String division, UserFitnessProfileModel profile) {
    switch (division) {
      case 'AB':
        return [
          _session('a', 'Treino A', 'Superiores', ['Peito', 'Costas', 'Ombro', 'Bíceps', 'Tríceps'], profile),
          _session('b', 'Treino B', 'Inferiores e abdômen', ['Pernas', 'Glúteos', 'Panturrilha', 'Abdômen'], profile),
        ];
      case 'ABC':
        return [
          _session('a', 'Treino A', 'Peito, ombro e tríceps', ['Peito', 'Ombro', 'Tríceps'], profile),
          _session('b', 'Treino B', 'Costas e bíceps', ['Costas', 'Bíceps'], profile),
          _session('c', 'Treino C', 'Pernas e abdômen', ['Pernas', 'Glúteos', 'Abdômen'], profile),
        ];
      case 'ABCD':
        return [
          _session('a', 'Treino A', 'Peito e tríceps', ['Peito', 'Tríceps'], profile),
          _session('b', 'Treino B', 'Costas e bíceps', ['Costas', 'Bíceps'], profile),
          _session('c', 'Treino C', 'Pernas', ['Pernas', 'Glúteos', 'Panturrilha'], profile),
          _session('d', 'Treino D', 'Ombro e abdômen', ['Ombro', 'Abdômen'], profile),
        ];
      case 'ABCDE':
        return [
          _session('a', 'Treino A', 'Peito', ['Peito'], profile),
          _session('b', 'Treino B', 'Costas', ['Costas'], profile),
          _session('c', 'Treino C', 'Pernas', ['Pernas', 'Glúteos'], profile),
          _session('d', 'Treino D', 'Ombros', ['Ombro'], profile),
          _session('e', 'Treino E', 'Braços e abdômen', ['Bíceps', 'Tríceps', 'Abdômen'], profile),
        ];
      case 'UPPER_LOWER':
        return [
          _session('upper-a', 'Upper A', 'Superiores', ['Peito', 'Costas', 'Ombro', 'Braços'], profile),
          _session('lower-a', 'Lower A', 'Inferiores', ['Pernas', 'Glúteos', 'Panturrilha', 'Abdômen'], profile),
        ];
      case 'PUSH_PULL_LEGS':
        return [
          _session('push', 'Push', 'Peito, ombro e tríceps', ['Peito', 'Ombro', 'Tríceps'], profile),
          _session('pull', 'Pull', 'Costas, bíceps e trapézio', ['Costas', 'Bíceps', 'Trapézio'], profile),
          _session('legs', 'Legs', 'Pernas e abdômen', ['Pernas', 'Glúteos', 'Panturrilha', 'Abdômen'], profile),
        ];
      default:
        return [
          _session('full-a', 'Full Body A', 'Corpo inteiro', ['Pernas', 'Peito', 'Costas', 'Ombro', 'Abdômen'], profile),
          _session('full-b', 'Full Body B', 'Corpo inteiro', ['Pernas', 'Costas', 'Peito', 'Braços', 'Abdômen'], profile),
          _session('full-c', 'Full Body C', 'Corpo inteiro', ['Glúteos', 'Ombro', 'Costas', 'Peito', 'Abdômen'], profile),
        ].take(profile.weeklyTrainingDays.clamp(2, 3)).toList();
    }
  }

  TrainingSessionModel _session(
    String id,
    String title,
    String subtitle,
    List<String> groups,
    UserFitnessProfileModel profile,
  ) {
    final maxExercises = profile.timePerWorkout == 'forty_five_minutes'
        ? 5
        : profile.timePerWorkout == 'one_hour'
        ? 6
        : 8;
    return TrainingSessionModel(
      id: id,
      title: title,
      subtitle: subtitle,
      muscleGroups: groups,
      estimatedDurationMinutes: _durationMinutes(profile),
      exercises: groups.expand((group) => _exercisesForGroup(group, profile)).take(maxExercises).toList(),
    );
  }

  List<ExerciseModel> _exercisesForGroup(String group, UserFitnessProfileModel profile) {
    final home = profile.trainingLocation == 'home';
    final rest = profile.mainGoal == 'strength' ? 150 : profile.mainGoal == 'weight_loss' ? 60 : 90;
    final reps = profile.mainGoal == 'strength' ? '5-8' : profile.mainGoal == 'endurance' ? '12-15' : '8-12';

    List<String> names;
    if (home && profile.equipments.isEmpty) {
      names = _bodyweightExercises(group);
    } else {
      names = _gymExercises(group);
    }

    return names.map((name) {
      return ExerciseModel(
        id: name.toLowerCase().replaceAll(' ', '-'),
        name: name,
        sets: _setsFor(profile),
        reps: reps,
        restSeconds: rest,
        notes: profile.mainGoal == 'weight_loss'
            ? 'Mantenha ritmo controlado e inclua cardio leve ao final se estiver bem.'
            : 'Mantenha execução controlada e progrida carga com segurança.',
        muscleGroup: group,
      );
    }).toList();
  }

  List<String> _gymExercises(String group) {
    switch (group) {
      case 'Peito':
        return ['Supino reto', 'Supino inclinado', 'Crucifixo'];
      case 'Costas':
        return ['Puxada alta', 'Remada baixa', 'Pulldown'];
      case 'Ombro':
        return ['Desenvolvimento', 'Elevação lateral'];
      case 'Bíceps':
      case 'Braços':
        return ['Rosca direta', 'Rosca martelo'];
      case 'Tríceps':
        return ['Tríceps pulley', 'Tríceps corda'];
      case 'Pernas':
        return ['Agachamento', 'Leg press', 'Cadeira extensora'];
      case 'Glúteos':
        return ['Elevação pélvica', 'Cadeira abdutora'];
      case 'Panturrilha':
        return ['Panturrilha em pé'];
      case 'Abdômen':
        return ['Abdominal prancha', 'Crunch'];
      default:
        return ['Exercício funcional'];
    }
  }

  List<String> _bodyweightExercises(String group) {
    switch (group) {
      case 'Peito':
        return ['Flexão de braço'];
      case 'Costas':
        return ['Remada com toalha'];
      case 'Pernas':
        return ['Agachamento livre', 'Avanço alternado'];
      case 'Glúteos':
        return ['Ponte de glúteos'];
      case 'Ombro':
        return ['Elevação lateral improvisada'];
      case 'Abdômen':
        return ['Prancha', 'Abdominal curto'];
      default:
        return ['Polichinelo controlado'];
    }
  }

  int _setsFor(UserFitnessProfileModel profile) {
    if (profile.alreadyTrainedStatus == 'never_trained') return 3;
    if (profile.stoppedTrainingTime == 'more_than_one_year') return 3;
    return 4;
  }

  int _durationMinutes(UserFitnessProfileModel profile) {
    switch (profile.timePerWorkout) {
      case 'forty_five_minutes':
        return 45;
      case 'one_hour_thirty':
        return profile.selfDeclaredLevel == 'beginner' ? 60 : 80;
      case 'two_hours':
        return profile.selfDeclaredLevel == 'advanced' ? 90 : 70;
      default:
        return 60;
    }
  }

  String _divisionLabel(String division) {
    switch (division) {
      case 'FULL_BODY':
        return 'Full Body';
      case 'UPPER_LOWER':
        return 'Upper/Lower';
      case 'PUSH_PULL_LEGS':
        return 'Push Pull Legs';
      default:
        return division;
    }
  }

  String _levelLabel(UserFitnessProfileModel profile) {
    switch (profile.selfDeclaredLevel) {
      case 'advanced':
        return 'Avançado';
      case 'intermediate':
        return 'Intermediário';
      case 'basic':
        return 'Básico';
      default:
        return 'Iniciante';
    }
  }

  String _goalLabel(String goal) {
    switch (goal) {
      case 'weight_loss':
        return 'Emagrecimento';
      case 'hypertrophy':
        return 'Hipertrofia';
      case 'strength':
        return 'Força';
      case 'conditioning':
        return 'Condicionamento';
      case 'return_to_training':
        return 'Voltar a treinar';
      case 'mobility':
        return 'Mobilidade';
      case 'endurance':
        return 'Resistência';
      default:
        return 'Saúde e qualidade de vida';
    }
  }

  String _descriptionFor(UserFitnessProfileModel profile, String division) {
    return 'Plano ${_divisionLabel(division)} criado para ${_goalLabel(profile.mainGoal).toLowerCase()}, respeitando ${profile.weeklyTrainingDays} dias por semana e seu tempo disponível.';
  }

  String _explanationFor(UserFitnessProfileModel profile, String division) {
    if (profile.stoppedTrainingTime == 'more_than_one_year') {
      return 'Mesmo com experiência anterior, escolhemos volume controlado porque você está voltando após um período parado.';
    }
    if (profile.alreadyTrainedStatus == 'never_trained') {
      return 'Escolhemos ${_divisionLabel(division)} para criar rotina, aprender os movimentos e evoluir com segurança.';
    }
    if (profile.mainGoal == 'weight_loss') {
      return 'Priorizamos uma divisão eficiente, com exercícios globais e possibilidade de condicionamento sem volume exagerado.';
    }
    return 'Escolhemos essa divisão por combinar sua frequência semanal, nível atual e objetivo principal.';
  }
}
