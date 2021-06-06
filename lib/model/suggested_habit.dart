class SuggestedHabit {
  int topicId;
  String habitName;
  String description;
  int icon;
  String color;
  bool isSetGoal;
  int? amount;
  String? unit;
  int? repeatMode;
  String? dayOfWeek;
  int? timesPerWeek;
  String? dateOfMonth;
  String? timeOfDay;

  SuggestedHabit({
    required this.topicId,
    required this.habitName,
    required this.description,
    required this.icon,
    required this.color,
    this.isSetGoal = false,
    this.amount,
    this.unit,
    this.repeatMode,
    this.dayOfWeek,
    this.dateOfMonth,
    this.timesPerWeek,
    this.timeOfDay,
  });

  Map<String, dynamic> toMap() {
    return {
      'topic_id': topicId,
      'habit_name': habitName,
      'description': description,
      'icon': icon,
      'color': color,
      'is_set_goal': isSetGoal ? 1 : 0,
      'amount': amount,
      'unit': unit,
      'repeat_mode': repeatMode,
      'day_of_week': dayOfWeek,
      'times_per_week': timesPerWeek,
      'date_of_month': dateOfMonth,
      'time_of_day': timeOfDay,
    };
  }

  factory SuggestedHabit.fromMap(Map<String, dynamic> map) {
    return SuggestedHabit(
      topicId: map['topic_id'],
      habitName: map['habit_name'],
      description: map['description'],
      icon: map['icon'],
      color: map['color'],
      isSetGoal: map['is_set_goal'] == 1 ? true : false,
      amount: map['amount'],
      unit: map['unit'],
      repeatMode: map['repeat_mode'],
      dayOfWeek: map['day_of_week'],
      timesPerWeek: map['times_per_week'],
      dateOfMonth: map['date_of_month'],
      timeOfDay: map['time_of_day'],
    );
  }
}
