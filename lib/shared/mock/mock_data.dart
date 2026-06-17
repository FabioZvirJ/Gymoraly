import '../models/community_post_model.dart';
import '../models/exercise_model.dart';
import '../models/meal_model.dart';
import '../models/professional_model.dart';
import '../models/workout_model.dart';

class MockData {
  static List<WorkoutModel> recommendedWorkouts({
    required String? goal,
    required int? daysPerWeek,
  }) {
    final normalizedGoal = (goal == null || goal.trim().isEmpty)
        ? 'Hipertrofia'
        : goal;
    final days = (daysPerWeek == null || daysPerWeek < 1)
        ? 3
        : daysPerWeek.clamp(1, 6);
    final preferred = _workoutForDays(days, normalizedGoal);
    final alternatives = <WorkoutModel>[
      _workoutForDays(3, normalizedGoal),
      _workoutForDays(4, normalizedGoal),
      _workoutForDays(5, normalizedGoal),
    ].where((workout) => workout.id != preferred.id).toList();

    return [preferred, ...alternatives.take(2)];
  }

  static WorkoutModel _workoutForDays(int days, String goal) {
    final isFatLoss = goal == 'Emagrecimento' || goal == 'Condicionamento';
    final suffix = isFatLoss ? ' + Cardio' : '';
    final level = days >= 5
        ? 'AvanÃ§ado'
        : days >= 3
        ? 'IntermediÃ¡rio'
        : 'Iniciante';
    final duration = isFatLoss ? 55 : 50;

    switch (days) {
      case 1:
        return _templateWorkout(
          id: 'full-body-$goal',
          title: 'Full Body$suffix',
          durationMinutes: isFatLoss ? 45 : 40,
          level: 'Iniciante',
          groups: ['Peito', 'Costas', 'Pernas', 'Ombro', 'AbdÃ´men'],
        );
      case 2:
        return _templateWorkout(
          id: 'ab-$goal',
          title: 'Treino AB$suffix',
          durationMinutes: duration,
          level: 'Iniciante',
          groups: ['Superiores', 'Inferiores', 'AbdÃ´men'],
        );
      case 3:
        return _templateWorkout(
          id: 'abc-$goal',
          title: 'Treino ABC$suffix',
          durationMinutes: duration,
          level: level,
          groups: ['Peito e TrÃ­ceps', 'Costas e BÃ­ceps', 'Pernas e Ombro'],
        );
      case 4:
        return _templateWorkout(
          id: 'abcd-$goal',
          title: 'Treino ABCD$suffix',
          durationMinutes: isFatLoss ? 60 : 55,
          level: level,
          groups: ['Peito', 'Costas', 'Pernas', 'Ombro e BraÃ§os'],
        );
      case 5:
        return _templateWorkout(
          id: 'abcde-$goal',
          title: 'Treino ABCDE$suffix',
          durationMinutes: isFatLoss ? 60 : 55,
          level: level,
          groups: ['Peito', 'Costas', 'Pernas', 'Ombro', 'BraÃ§os'],
        );
      default:
        return _templateWorkout(
          id: 'ppl-$goal',
          title: 'Push Pull Legs$suffix',
          durationMinutes: isFatLoss ? 65 : 60,
          level: 'AvanÃ§ado',
          groups: ['Push', 'Pull', 'Legs', 'Push', 'Pull', 'Legs'],
        );
    }
  }

  static WorkoutModel _templateWorkout({
    required String id,
    required String title,
    required int durationMinutes,
    required String level,
    required List<String> groups,
  }) {
    return WorkoutModel(
      id: id,
      title: title,
      durationMinutes: durationMinutes,
      level: level,
      exercises: groups
          .take(6)
          .map(
            (group) => ExerciseModel(
              id: group.toLowerCase().replaceAll(' ', '-'),
              name: _mainExerciseForGroup(group),
              sets: 4,
              reps: '12 reps',
              rest: '3:00 min',
              muscleGroup: group,
            ),
          )
          .toList(),
    );
  }

  static String _mainExerciseForGroup(String group) {
    if (group.contains('Peito') || group == 'Push') {
      return 'Supino reto';
    }
    if (group.contains('Costas') || group == 'Pull') {
      return 'Puxada alta';
    }
    if (group.contains('Pernas') || group == 'Inferiores' || group == 'Legs') {
      return 'Agachamento';
    }
    if (group.contains('Ombro')) {
      return 'Desenvolvimento';
    }
    if (group.contains('Braços') || group.contains('Bíceps')) {
      return 'Rosca direta';
    }
    if (group.contains('Abdômen')) {
      return 'Abdominal';
    }
    return 'Circuito funcional';
  }

  static const exercises = [
    ExerciseModel(
      id: 'supino-reto',
      name: 'Supino reto',
      sets: 4,
      reps: '10-12 reps',
      rest: '1:30 min',
      muscleGroup: 'Peito',
    ),
    ExerciseModel(
      id: 'supino-inclinado',
      name: 'Supino inclinado',
      sets: 3,
      reps: '10 reps',
      rest: '1:30 min',
      muscleGroup: 'Peito',
    ),
    ExerciseModel(
      id: 'crucifixo',
      name: 'Crucifixo',
      sets: 3,
      reps: '12 reps',
      rest: '1:00 min',
      muscleGroup: 'Peito',
    ),
    ExerciseModel(
      id: 'rosca-direta',
      name: 'Rosca direta',
      sets: 4,
      reps: '10 reps',
      rest: '1:00 min',
      muscleGroup: 'BÃ­ceps',
    ),
    ExerciseModel(
      id: 'rosca-martelo',
      name: 'Rosca martelo',
      sets: 3,
      reps: '12 reps',
      rest: '1:00 min',
      muscleGroup: 'BÃ­ceps',
    ),
    ExerciseModel(
      id: 'abdominal',
      name: 'Abdominal',
      sets: 3,
      reps: '15 reps',
      rest: '0:45 min',
      muscleGroup: 'AbdÃ´men',
    ),
    ExerciseModel(
      id: 'agachamento',
      name: 'Agachamento',
      sets: 4,
      reps: '8-10 reps',
      rest: '2:00 min',
      muscleGroup: 'Pernas',
    ),
    ExerciseModel(
      id: 'leg-press',
      name: 'Leg press',
      sets: 4,
      reps: '12 reps',
      rest: '1:30 min',
      muscleGroup: 'Pernas',
    ),
    ExerciseModel(
      id: 'desenvolvimento',
      name: 'Desenvolvimento',
      sets: 4,
      reps: '10 reps',
      rest: '1:20 min',
      muscleGroup: 'Ombro',
    ),
  ];

  static const workouts = [
    WorkoutModel(
      id: 'peito-biceps',
      title: 'Peito e BÃ­ceps',
      durationMinutes: 45,
      level: 'IntermediÃ¡rio',
      exercises: [
        ExerciseModel(
          id: 'supino-reto',
          name: 'Supino reto',
          sets: 4,
          reps: '10/12 reps',
          rest: '1:30 min',
          muscleGroup: 'Peito',
        ),
        ExerciseModel(
          id: 'supino-inclinado',
          name: 'Supino inclinado',
          sets: 3,
          reps: '10 reps',
          rest: '1:30 min',
          muscleGroup: 'Peito',
        ),
        ExerciseModel(
          id: 'crucifixo',
          name: 'Crucifixo',
          sets: 3,
          reps: '12 reps',
          rest: '1:00 min',
          muscleGroup: 'Peito',
        ),
        ExerciseModel(
          id: 'rosca-direta',
          name: 'Rosca direta',
          sets: 4,
          reps: '10 reps',
          rest: '1:00 min',
          muscleGroup: 'BÃ­ceps',
        ),
        ExerciseModel(
          id: 'rosca-martelo',
          name: 'Rosca martelo',
          sets: 3,
          reps: '12 reps',
          rest: '1:00 min',
          muscleGroup: 'BÃ­ceps',
        ),
        ExerciseModel(
          id: 'abdominal',
          name: 'Abdominal',
          sets: 3,
          reps: '15 reps',
          rest: '0:45 min',
          muscleGroup: 'AbdÃ´men',
        ),
      ],
    ),
    WorkoutModel(
      id: 'costas-triceps',
      title: 'Costas e TrÃ­ceps',
      durationMinutes: 50,
      level: 'IntermediÃ¡rio',
      exercises: [
        ExerciseModel(
          id: 'puxada',
          name: 'Puxada alta',
          sets: 4,
          reps: '10 reps',
          rest: '1:30 min',
          muscleGroup: 'Costas',
        ),
        ExerciseModel(
          id: 'remada',
          name: 'Remada baixa',
          sets: 4,
          reps: '12 reps',
          rest: '1:30 min',
          muscleGroup: 'Costas',
        ),
        ExerciseModel(
          id: 'triceps-corda',
          name: 'TrÃ­ceps corda',
          sets: 3,
          reps: '12 reps',
          rest: '1:00 min',
          muscleGroup: 'TrÃ­ceps',
        ),
      ],
    ),
    WorkoutModel(
      id: 'pernas',
      title: 'Pernas completo',
      durationMinutes: 60,
      level: 'AvanÃ§ado',
      exercises: [
        ExerciseModel(
          id: 'agachamento',
          name: 'Agachamento',
          sets: 4,
          reps: '8-10 reps',
          rest: '2:00 min',
          muscleGroup: 'Pernas',
        ),
        ExerciseModel(
          id: 'leg-press',
          name: 'Leg press',
          sets: 4,
          reps: '12 reps',
          rest: '1:30 min',
          muscleGroup: 'Pernas',
        ),
        ExerciseModel(
          id: 'cadeira',
          name: 'Cadeira extensora',
          sets: 3,
          reps: '12 reps',
          rest: '1:00 min',
          muscleGroup: 'Pernas',
        ),
      ],
    ),
    WorkoutModel(
      id: 'ombro-abdomen',
      title: 'Ombro e AbdÃ´men',
      durationMinutes: 40,
      level: 'Iniciante',
      exercises: [
        ExerciseModel(
          id: 'desenvolvimento',
          name: 'Desenvolvimento',
          sets: 4,
          reps: '10 reps',
          rest: '1:20 min',
          muscleGroup: 'Ombro',
        ),
        ExerciseModel(
          id: 'elevacao-lateral',
          name: 'ElevaÃ§Ã£o lateral',
          sets: 3,
          reps: '12 reps',
          rest: '1:00 min',
          muscleGroup: 'Ombro',
        ),
        ExerciseModel(
          id: 'abdominal',
          name: 'Abdominal',
          sets: 3,
          reps: '15 reps',
          rest: '0:45 min',
          muscleGroup: 'AbdÃ´men',
        ),
      ],
    ),
    WorkoutModel(
      id: 'cardio',
      title: 'Cardio rÃ¡pido',
      durationMinutes: 25,
      level: 'Iniciante',
      exercises: [
        ExerciseModel(
          id: 'bike',
          name: 'Bike',
          sets: 1,
          reps: '10 min',
          rest: '0:30 min',
          muscleGroup: 'Cardio',
        ),
        ExerciseModel(
          id: 'esteira',
          name: 'Esteira',
          sets: 1,
          reps: '12 min',
          rest: '0:30 min',
          muscleGroup: 'Cardio',
        ),
        ExerciseModel(
          id: 'corda',
          name: 'Corda',
          sets: 3,
          reps: '1 min',
          rest: '0:30 min',
          muscleGroup: 'Cardio',
        ),
      ],
    ),
  ];

  static const communityPosts = [
    CommunityPostModel(
      id: 'supino',
      title: 'Como evoluir no supino?',
      author: 'Glynto Silva',
      content:
          'Estou travado na carga do supino hÃ¡ algumas semanas. A melhor saÃ­da costuma ser ajustar volume, execuÃ§Ã£o e progressÃ£o semanal, sem sacrificar amplitude.',
      likes: 45,
      commentsCount: 12,
    ),
    CommunityPostModel(
      id: 'pernas-iniciantes',
      title: 'Treino de pernas para iniciantes',
      author: 'Renata Costa',
      content:
          'Para comeÃ§ar bem, priorize agachamento guiado, leg press e exercÃ­cios unilaterais simples. TÃ©cnica vem antes de carga.',
      likes: 32,
      commentsCount: 8,
    ),
    CommunityPostModel(
      id: 'proteina',
      title: 'Dicas para bater proteÃ­na',
      author: 'Comunidade',
      content:
          'Distribuir proteÃ­na ao longo do dia ajuda muito. Ovos, iogurte, frango, peixe e whey podem entrar conforme sua rotina.',
      likes: 60,
      commentsCount: 15,
    ),
  ];

  static const meals = [
    MealModel(
      id: 'cafe',
      name: 'CafÃ© da manhÃ£',
      type: 'CafÃ© da manhÃ£',
      calories: 430,
      completed: true,
      foods: ['Ovos mexidos', 'PÃ£o integral', 'CafÃ© sem aÃ§Ãºcar', 'Banana'],
    ),
    MealModel(
      id: 'almoco',
      name: 'AlmoÃ§o',
      type: 'AlmoÃ§o',
      calories: 720,
      completed: false,
      foods: ['Arroz integral', 'FeijÃ£o', 'Frango grelhado', 'Salada'],
    ),
    MealModel(
      id: 'jantar',
      name: 'Jantar',
      type: 'Jantar',
      calories: 610,
      completed: false,
      foods: ['TilÃ¡pia', 'Batata doce', 'Legumes assados'],
    ),
    MealModel(
      id: 'lanches',
      name: 'Lanches',
      type: 'Lanche',
      calories: 320,
      completed: false,
      foods: ['Iogurte natural', 'Granola', 'MaÃ§Ã£'],
    ),
  ];

  static const professionals = [
    ProfessionalModel(
      id: 'glynto',
      name: 'Glynto Silva',
      role: 'Personal Trainer',
      followers: '6.532',
      bio:
          'Especialista em hipertrofia e recomposiÃ§Ã£o corporal. Treinos prÃ¡ticos, progressivos e feitos para caber na rotina.',
      rating: 4.9,
    ),
    ProfessionalModel(
      id: 'renata',
      name: 'Renata Costa',
      role: 'Nutricionista',
      followers: '4.210',
      bio:
          'NutriÃ§Ã£o esportiva com foco em adesÃ£o, performance e ganho de massa magra sem complicar sua alimentaÃ§Ã£o.',
      rating: 4.8,
    ),
  ];
}
