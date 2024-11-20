// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/utils/enums/work_type_enum.dart';

class WorkRolePub {
  final String docId;
  final String userId;
  final WorkRole workRole;
  final String institutionDomain;
  final String institutionName;
  final String department;
  final DateTime startDate;
  final DateTime? endDate;
  final bool institutionApproved;
  final bool endDateApproved;
  final DateTime lastWriteAt;

  WorkRolePub({
    required this.docId,
    required this.userId,
    required this.workRole,
    required this.institutionDomain,
    required this.institutionName,
    required this.department,
    required this.startDate,
    required this.endDate,
    required this.institutionApproved,
    required this.endDateApproved,
    required this.lastWriteAt
  });

}
