import '../../../../core/utils/classes/approve_details.dart';
import 'degree_field_of_study.dart';

/// ***Only accessed by legitimate student and institute admins.***
class EducationPrv {
  final String docId; // document or data id (same as student collection's document id)
  final String userId;
  final String userName;
  String studentId;
  String email;
  String contactNo;
  String institutionDomain;
  String institutionName;
  Degree? degree;
  DateTime startDate;
  DateTime? endDate;
  final ApproveDetails? approveDetails;
  final DateTime lastWriteAt;

  EducationPrv({
    required this.docId,
    required this.userId,
    required this.userName,
    required this.studentId,
    required this.email,
    required this.contactNo,
    required this.institutionDomain,
    required this.institutionName,
    required this.degree,
    required this.startDate,
    required this.endDate,
    required this.approveDetails,
    required this.lastWriteAt,
  });

  factory EducationPrv.newInstance({
    required String newDocId,
    required String currentUserId,
  }){
    return EducationPrv(
      docId: newDocId,
      userId: currentUserId,
      userName: '',
      studentId: '',
      email: '',
      contactNo: '',
      institutionDomain: '',
      institutionName: '',
      degree: null,
      startDate: DateTime.now(),
      endDate: null,
      approveDetails: null,
      lastWriteAt: DateTime.now()
    );
  }


}
