class SuggestedTopic {
  int topicId;
  String topicName;
  String description;
  String image;

  SuggestedTopic({
    required this.topicId,
    required this.topicName,
    required this.description,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'topic_id': topicId,
      'topic_name': topicName,
      'description': description,
      'image': image,
    };
  }

  factory SuggestedTopic.fromMap(Map<String, dynamic> map) {
    return SuggestedTopic(
      topicId: map['topic_id'],
      topicName: map['topic_name'],
      description: map['description'],
      image: map['image'],
    );
  }
}
