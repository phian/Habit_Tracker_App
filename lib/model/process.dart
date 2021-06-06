class Process {
  int habitId;
  String date;
  int result;
  bool isSkip;

  Process({
    required this.habitId,
    required this.date,
    this.result = 0,
    this.isSkip = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'habit_id': habitId,
      'date': date,
      'result': result,
      'is_skip': isSkip ? 1 : 0,
    };
  }

  factory Process.fromMap(Map<String, dynamic> map) {
    return Process(
      habitId: map['habit_id'],
      date: map['date'],
      result: map['result'],
      isSkip: map['is_skip'] == 1 ? true : false,
    );
  }
}
