class MealModel {
  const MealModel({
    required this.id,
    required this.name,
    required this.type,
    required this.calories,
    required this.completed,
    required this.foods,
  });

  final String id;
  final String name;
  final String type;
  final int calories;
  final bool completed;
  final List<String> foods;
}
