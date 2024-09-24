class Habit {
  final String name;
  int streak;
  bool completed;
  int level;
  DateTime? lastCompletedDate;

  Habit({
    required this.name,
    this.streak = 0,
    this.completed = false,
    this.level = 1,
    this.lastCompletedDate
  });

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      name: json['name'],
      streak: json['streak'],
      level: json['level'],
      completed: json['completed'],
      lastCompletedDate: json['lastCompletedDate'] != null
          ? DateTime.parse(json['lastCompletedDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'streak': streak,
      'level': level,
      'completed': completed,
      'lastCompletedDate': lastCompletedDate?.toIso8601String(),
    };
  }
}
