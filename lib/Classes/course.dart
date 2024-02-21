class Course {
  Course({
    required this.consultantName,
    required this.courseImageURL,
    required this.courseName,
    required this.courseURL,
  });

  String courseName = "";
  String consultantName = "";
  String courseImageURL = "";
  final String courseURL;

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseURL: json['course_url'],
      consultantName: json['consultant_name'],
      courseImageURL: json['course_image_url'],
      courseName: json['course_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'course_url': courseURL,
      };
}
