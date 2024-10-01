class Education {
  final String id; // document or data id
  final String userId;
  final String institutionDomain;
  final String institutionName;
  final String degree;
  final String subject;
  final DateTime startDate;
  final DateTime endDate;
  final bool institutionApproved;
  final bool graduationApproved;

  Education({
    required this.id,
    required this.userId,
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