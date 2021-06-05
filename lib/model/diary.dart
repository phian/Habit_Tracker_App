class Diary {
  int habitId;
  String date;
  String content;

  Diary({
    required this.habitId,
    required this.content,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'habit_id': habitId,
      'date': date,
      'content': content,
    };
  }

  factory Diary.fromMap(Map<String, dynamic> map) {
    return Diary(
      habitId: map['habit_id'],
      date: map['date'],
      content: map['content'],
    );
  }
}
