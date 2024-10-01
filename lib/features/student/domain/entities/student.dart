class Student {
  final String id; // document or data id (same as student collection's document id)
  final String studentId;
  final String email;
  final String contactNo;
  final String institutionDomain;
  final String institutionName;
  final String degree;
  final String subject;
  final DateTime startDate;
  final DateTime endDate;
  final bool institutionApproved;
  final bool graduationApproved;

  Student({
    required this.id,
    required this.studentId,
    required this.email,
    required this.contactNo,
    required this.institutionDomain,
    required this.institutionName,
    required this.degree,
    required this.subject,
    required this.startDate,
    required this.endDate,
    required this.institutionApproved,
    required this.graduationApproved
  });
}