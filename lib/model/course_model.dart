class CourseModel {
  final String id;
  final String sp_id;
  final String name;
  final String price;
  final String duration;
  final String desc;
  final bool isActive;

  CourseModel({
    required this.id,
    required this.sp_id,
    required this.name,
    required this.price,
    required this.duration,
    required this.desc,
    required this.isActive,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['course_id'],
      name: json['name'],
      sp_id: json['course_sp_id'],
      price: json['price'],
      duration: json['duration'],
      desc: json['desc'],
      isActive: json['isActive'],
    );
  }
}