import 'dart:convert';

import '../models/user_fitness_profile_model.dart';

class AiWorkoutPromptBuilder {
  String buildPrompt(UserFitnessProfileModel profile) {
    return '''
Você é um personal trainer especialista em musculação, hipertrofia, emagrecimento, força, condicionamento e treinamento para iniciantes.

Crie um plano de treino personalizado com base no perfil abaixo.

Regras:
- Não prescreva nada perigoso.
- Não prometa resultado.
- Se houver dor, lesão ou limitação, adapte os exercícios e recomende procurar profissional.
- Escolha a melhor divisão entre AB, ABC, ABCD, ABCDE, Full Body, Upper/Lower ou Push Pull Legs.
- Respeite a quantidade de dias disponíveis por semana.
- Respeite o tempo disponível por sessão, sem precisar usar todo o tempo.
- Use nomes de exercícios comuns em português.
- Se treinar em casa sem equipamentos, use peso corporal.
- Retorne apenas JSON válido, sem markdown.

Perfil do usuário:
${jsonEncode(profile.toJson())}
''';
  }
}
