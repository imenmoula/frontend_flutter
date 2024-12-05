class ClassModel {
  final String classId;
  final String subjectId;
  final String className;
  final List<String> students;

  ClassModel({
    required this.classId,
    required this.subjectId,
    required this.className,
    required this.students,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    var studentsList = List<String>.from(json['students']);
    return ClassModel(
      classId: json['class_id'],
      subjectId: json['subject_id'],
      className: json['class_name'],
      students: studentsList,
    );
  }
}
