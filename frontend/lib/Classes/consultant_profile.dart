class ConsultantProfile {
  String imageURL;
  String consultantName;
  String consultantTitle;
  List<String> clients;

  ConsultantProfile(
      {required this.imageURL,
      required this.consultantName,
      required this.consultantTitle,
      required this.clients});

  factory ConsultantProfile.fromJson(Map<String, dynamic> json) {
    return ConsultantProfile(
      imageURL: json['image_url'],
      consultantName: json['consultant_name'],
      consultantTitle: json['consultant_title'],
      clients: json['clients'],
    );
  }

  Map<String, dynamic> toJson() => {
        'image_url': imageURL,
        'consultant_name': consultantName,
        'consultant_title': consultantTitle,
        'clients': clients,
      };
}
