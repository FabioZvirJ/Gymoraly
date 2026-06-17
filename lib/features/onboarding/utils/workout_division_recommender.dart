import '../models/user_fitness_profile_model.dart';

class WorkoutDivisionRecommender {
  String recommendDivision(UserFitnessProfileModel profile) {
    final days = profile.weeklyTrainingDays;
    final level = _effectiveLevel(profile);
    final returningAfterLongBreak =
        profile.stoppedTrainingTime == 'six_months_to_one_year' || profile.stoppedTrainingTime == 'more_than_one_year';
    final fatLoss = profile.mainGoal == 'weight_loss' || profile.mainGoal == 'conditioning';

    if (profile.hasLimitations || returningAfterLongBreak) {
      if (days <= 3) return 'FULL_BODY';
      return 'UPPER_LOWER';
    }

    if (profile.alreadyTrainedStatus == 'never_trained' || level == 'beginner' || level == 'basic') {
      if (days <= 3) return 'FULL_BODY';
      if (days == 4) return 'AB';
      return fatLoss ? 'AB' : 'ABC';
    }

    if (level == 'intermediate') {
      if (days <= 2) return 'AB';
      if (days == 3) return fatLoss ? 'FULL_BODY' : 'ABC';
      if (days == 4) return 'UPPER_LOWER';
      if (days == 5) return fatLoss ? 'ABC' : 'ABCD';
      return fatLoss ? 'ABC' : 'PUSH_PULL_LEGS';
    }

    if (days <= 3) return 'ABC';
    if (days == 4) return 'ABCD';
    if (days == 5) return 'ABCDE';
    return 'PUSH_PULL_LEGS';
  }

  String _effectiveLevel(UserFitnessProfileModel profile) {
    if (profile.stoppedTrainingTime == 'more_than_one_year') return 'basic';
    if (profile.alreadyTrainedStatus == 'never_trained') return 'beginner';
    return profile.selfDeclaredLevel;
  }
}
