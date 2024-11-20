

// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../core/utils/classes/approve_details.dart';

import 'degree_field_of_study.dart';

class EducationPub{
  final String docId; // document or data id
  final String userId;
  final String userName;
  final String institutionDomain;
  final String institutionName;
  final Degree? degree;
  final DateTime startDate;
  final DateTime? endDate;
  final bool institutionApproved;
  final DateTime lastWriteAt;

  EducationPub({
    required this.docId,
    required this.userId,
    required this.userName,
    required this.institutionDomain,
    required this.institutionName,
    required this.degree,
    required this.startDate,
    required this.endDate,
    required this.institutionApproved,
    required this.lastWriteAt
  });


}
