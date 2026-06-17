import '../models/community_post_model.dart';
import '../models/exercise_model.dart';
import '../models/meal_model.dart';
import '../models/professional_model.dart';
import '../models/workout_model.dart';

class MockData {
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
      muscleGroup: 'Bíceps',
    ),
    ExerciseModel(
      id: 'rosca-martelo',
      name: 'Rosca martelo',
      sets: 3,
      reps: '12 reps',
      rest: '1:00 min',
      muscleGroup: 'Bíceps',
    ),
    ExerciseModel(
      id: 'abdominal',
      name: 'Abdominal',
      sets: 3,
      reps: '15 reps',
      rest: '0:45 min',
      muscleGroup: 'Abdômen',
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
      title: 'Peito e Bíceps',
      durationMinutes: 45,
      level: 'Intermediário',
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
          muscleGroup: 'Bíceps',
        ),
        ExerciseModel(
          id: 'rosca-martelo',
          name: 'Rosca martelo',
          sets: 3,
          reps: '12 reps',
          rest: '1:00 min',
          muscleGroup: 'Bíceps',
        ),
        ExerciseModel(
          id: 'abdominal',
          name: 'Abdominal',
          sets: 3,
          reps: '15 reps',
          rest: '0:45 min',
          muscleGroup: 'Abdômen',
        ),
      ],
    ),
    WorkoutModel(
      id: 'costas-triceps',
      title: 'Costas e Tríceps',
      durationMinutes: 50,
      level: 'Intermediário',
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
          name: 'Tríceps corda',
          sets: 3,
          reps: '12 reps',
          rest: '1:00 min',
          muscleGroup: 'Tríceps',
        ),
      ],
    ),
    WorkoutModel(
      id: 'pernas',
      title: 'Pernas completo',
      durationMinutes: 60,
      level: 'Avançado',
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
      title: 'Ombro e Abdômen',
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
          name: 'Elevação lateral',
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
          muscleGroup: 'Abdômen',
        ),
      ],
    ),
    WorkoutModel(
      id: 'cardio',
      title: 'Cardio rápido',
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
          'Estou travado na carga do supino há algumas semanas. A melhor saída costuma ser ajustar volume, execução e progressão semanal, sem sacrificar amplitude.',
      likes: 45,
      commentsCount: 12,
    ),
    CommunityPostModel(
      id: 'pernas-iniciantes',
      title: 'Treino de pernas para iniciantes',
      author: 'Renata Costa',
      content:
          'Para começar bem, priorize agachamento guiado, leg press e exercícios unilaterais simples. Técnica vem antes de carga.',
      likes: 32,
      commentsCount: 8,
    ),
    CommunityPostModel(
      id: 'proteina',
      title: 'Dicas para bater proteína',
      author: 'Comunidade',
      content:
          'Distribuir proteína ao longo do dia ajuda muito. Ovos, iogurte, frango, peixe e whey podem entrar conforme sua rotina.',
      likes: 60,
      commentsCount: 15,
    ),
  ];

  static const meals = [
    MealModel(
      id: 'cafe',
      name: 'Café da manhã',
      type: 'Café da manhã',
      calories: 430,
      completed: true,
      foods: ['Ovos mexidos', 'Pão integral', 'Café sem açúcar', 'Banana'],
    ),
    MealModel(
      id: 'almoco',
      name: 'Almoço',
      type: 'Almoço',
      calories: 720,
      completed: false,
      foods: ['Arroz integral', 'Feijão', 'Frango grelhado', 'Salada'],
    ),
    MealModel(
      id: 'jantar',
      name: 'Jantar',
      type: 'Jantar',
      calories: 610,
      completed: false,
      foods: ['Tilápia', 'Batata doce', 'Legumes assados'],
    ),
    MealModel(
      id: 'lanches',
      name: 'Lanches',
      type: 'Lanche',
      calories: 320,
      completed: false,
      foods: ['Iogurte natural', 'Granola', 'Maçã'],
    ),
  ];

  static const professionals = [
    ProfessionalModel(
      id: 'glynto',
      name: 'Glynto Silva',
      role: 'Personal Trainer',
      followers: '6.532',
      bio:
          'Especialista em hipertrofia e recomposição corporal. Treinos práticos, progressivos e feitos para caber na rotina.',
      rating: 4.9,
    ),
    ProfessionalModel(
      id: 'renata',
      name: 'Renata Costa',
      role: 'Nutricionista',
      followers: '4.210',
      bio:
          'Nutrição esportiva com foco em adesão, performance e ganho de massa magra sem complicar sua alimentação.',
      rating: 4.8,
    ),
  ];
}
