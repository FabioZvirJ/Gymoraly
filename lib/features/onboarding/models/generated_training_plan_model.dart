import 'training_session_model.dart';

class GeneratedTrainingPlanModel {
  const GeneratedTrainingPlanModel({
    required this.id,
    required this.title,
    required this.description,
    required this.divisionType,
    required this.level,
    required this.goal,
    required this.weeklyFrequency,
    required this.estimatedDuration,
    required this.aiExplanation,
    required this.sessions,
  });

  final String id;
  final String title;
  final String description;
  final String divisionType;
  final String level;
  final String goal;
  final String weeklyFrequency;
  final String estimatedDuration;
  final String aiExplanation;
  final List<TrainingSessionModel> sessions;

  GeneratedTrainingPlanModel copyWith({
    String? id,
    String? title,
    String? description,
    String? divisionType,
    String? level,
    String? goal,
    String? weeklyFrequency,
    String? estimatedDuration,
    String? aiExplanation,
    List<TrainingSessionModel>? sessions,
  }) {
    return GeneratedTrainingPlanModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      divisionType: divisionType ?? this.divisionType,
      level: level ?? this.level,
      goal: goal ?? this.goal,
      weeklyFrequency: weeklyFrequency ?? this.weeklyFrequency,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      aiExplanation: aiExplanation ?? this.aiExplanation,
      sessions: sessions ?? this.sessions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'divisionType': divisionType,
      'level': level,
      'goal': goal,
      'weeklyFrequency': weeklyFrequency,
      'estimatedDuration': estimatedDuration,
      'aiExplanation': aiExplanation,
      'sessions': sessions.map((session) => session.toJson()).toList(),
    };
  }

  factory GeneratedTrainingPlanModel.fromJson(Map<String, dynamic> json) {
    return GeneratedTrainingPlanModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      divisionType: json['divisionType'] as String? ?? 'FULL_BODY',
      level: json['level'] as String? ?? 'Iniciante',
      goal: json['goal'] as String? ?? 'Saúde',
      weeklyFrequency: json['weeklyFrequency'] as String? ?? '3x por semana',
      estimatedDuration: json['estimatedDuration'] as String? ?? '45 minutos por sessão',
      aiExplanation: json['aiExplanation'] as String? ?? '',
      sessions: (json['sessions'] as List<dynamic>? ?? [])
          .map((item) => TrainingSessionModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
