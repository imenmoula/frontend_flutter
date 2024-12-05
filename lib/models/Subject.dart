class Subject {
  final String subjectId;
  final String subjectName;
  final String subjectCode;
  final String department;
  final String description;

  Subject({
    required this.subjectId,
    required this.subjectName,
    required this.subjectCode,
    required this.department,
    required this.description,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectId: json['subject_id'],
      subjectName: json['subject_name'],
      subjectCode: json['subject_code'],
      department: json['department'],
      description: json['description'],
    );
  }
}
