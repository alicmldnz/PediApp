
class Activity {
  const Activity(
      {required this.categoryName,
        required this.categoryColor,
        required this.categoryUrl});

  final String categoryName;
  final String categoryColor;
  final String categoryUrl;

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      categoryName: json['activity_name'],
      categoryColor: json['activity_color'],
      categoryUrl: json['activity_url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'activity_name': categoryName,
    'activity_color': categoryColor,
    'activity_url': categoryUrl,
  };
}
