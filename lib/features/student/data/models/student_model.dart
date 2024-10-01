import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/student.dart';

part 'student_model.freezed.dart';
part 'student_model.g.dart';

@Freezed()
@JsonSerializable()
class StudentModel extends Student with _$StudentModel {
  const factory StudentModel({
    required String id,
    required String studentId,
    required String email,
    required String contactNo,
    required String institutionDomain,
    required String institutionName,
    required String degree,
    required String subject,
    required DateTime startDate,
    required DateTime endDate,
    required bool institutionApproved,
    required bool graduationApproved,
  }) = _StudentModel;

  factory StudentModel.fromJson({required Map<String, dynamic> json}) =>
      _$StudentModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StudentModelToJson(this);

  factory StudentModel.fromEntity({required Student student}) => StudentModel(
        id: student.id,
        studentId: student.studentId,
        email: student.email,
        contactNo: student.contactNo,
        institutionDomain: student.institutionDomain,
        institutionName: student.institutionName,
        degree: student.degree,
        subject: student.subject,
        startDate: student.startDate,
        endDate: student.endDate,
        institutionApproved: student.institutionApproved,
        graduationApproved: student.graduationApproved,
      );

  // factory StudentModel.fromMap({required Map<String, dynamic> map}) {
  //   return StudentModel(
  //     id: map[kuserId] ?? '',
  //     studentId: map[kstudentId] ?? '',
  //     email: map[kemail] ?? '',
  //     contactNo: map[kcontactNo] ?? '',
  //     institutionDomain: map[kinstitutionDomain],
  //     institutionName: map[kinstitutionName] ?? '',
  //     degree: map[kdegree],
  //     subject: map[ksubject],
  //     startDate: map[kstartDate],
  //     endDate: map[kendDate],
  //     institutionApproved: map[kinstitutionApproved],
  //     graduationApproved: map[kgraduationApproved],
  //   );
  // }
}
