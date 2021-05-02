class Habit {
  int habitId;
  String habitName;
  int icon;
  String color;
  bool isSetGoal;
  int amount;
  String unit;
  int repeatMode;
  String dayOfWeek;
  int timesPerWeek;
  String dateOfMonth;
  String timeOfDay;
  bool isSetReminder;
  bool status;

  Habit({
    this.habitId,
    this.habitName,
    this.icon,
    this.color,
    this.isSetGoal,
    this.amount,
    this.unit,
    this.repeatMode,
    this.dayOfWeek,
    this.timesPerWeek,
    this.dateOfMonth,
    this.timeOfDay,
    this.isSetReminder,
    this.status = false,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (habitId != null) map['habit_id'] = habitId;
    map['habit_name'] = habitName;
    map['icon'] = icon;
    map['color'] = color;
    map['is_set_goal'] = isSetGoal ? 1 : 0;
    map['amount'] = amount;
    map['unit'] = unit;
    map['repeat_mode'] = repeatMode;
    map['day_of_week'] = dayOfWeek;
    map['times_per_week'] = timesPerWeek;
    map['date_of_month'] = dateOfMonth;
    map['time_of_day'] = timeOfDay;
    if (isSetReminder != null) map['is_set_reminder'] = isSetReminder ? 1 : 0;
    if (status != null) map['status'] = status ? 1 : 0;
    return map;
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      habitId: map['habit_id'],
      habitName: map['habit_name'],
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
      isSetReminder: map['is_set_reminder'] == 1 ? true : false,
      status: map['status'] == 1 ? true : false,
    );
  }
}
