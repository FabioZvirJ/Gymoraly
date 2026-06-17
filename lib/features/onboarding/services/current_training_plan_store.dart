import 'package:flutter/foundation.dart';

import '../models/generated_training_plan_model.dart';

class CurrentTrainingPlanStore extends ChangeNotifier {
  CurrentTrainingPlanStore._();

  static final CurrentTrainingPlanStore instance = CurrentTrainingPlanStore._();

  GeneratedTrainingPlanModel? _currentPlan;

  GeneratedTrainingPlanModel? get currentPlan => _currentPlan;

  void acceptPlan(GeneratedTrainingPlanModel plan) {
    _currentPlan = plan;
    notifyListeners();
  }

  void clear() {
    _currentPlan = null;
    notifyListeners();
  }
}
