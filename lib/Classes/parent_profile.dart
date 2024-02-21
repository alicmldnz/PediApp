class ParentProfile {
  String imageURL;
  String parentName;
  String childName;

  ParentProfile(
      {required this.imageURL,
      required this.parentName,
      required this.childName});

  factory ParentProfile.fromJson(Map<String, dynamic> json) {
    return ParentProfile(
      imageURL: json['image_url'],
      parentName: json['parent_name'],
      childName: json['child_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'image_url': imageURL,
        'parent_name': parentName,
        'child_name': childName,
      };
}
