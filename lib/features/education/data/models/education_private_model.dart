import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormsity/core/utils/classes/approve_details.dart';
import 'package:dormsity/features/education/data/models/degree_field_of_study_model.dart';

import '../../domain/entities/education_private.dart';

class EducationPrvModel extends EducationPrv {
  @override
  final DegreeModel degree;
  
  EducationPrvModel({
    required super.docId,
    required super.userId,
    required super.userName,
    required super.studentId,
    required super.email,
    required super.contactNo,
    required super.institutionDomain,
    required super.institutionName,
    required this.degree,
    required super.startDate,
    required super.endDate,
    required super.approveDetails,
    required super.lastWriteAt
  }): super(degree: degree);


  factory EducationPrvModel.fromEntity(EducationPrv educationPrv) {
    return EducationPrvModel(
      docId: educationPrv.docId,
      userId: educationPrv.userId,
      userName: educationPrv.userName,
      studentId: educationPrv.studentId,
      email: educationPrv.email,
      contactNo: educationPrv.contactNo,
      institutionDomain: educationPrv.institutionDomain,
      institutionName: educationPrv.institutionName,
      degree: DegreeModel.fromEntity(educationPrv.degree!),
      startDate: educationPrv.startDate,
      endDate: educationPrv.endDate,
      approveDetails: educationPrv.approveDetails,
      lastWriteAt: educationPrv.lastWriteAt
    );
  }


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'userId': userId,
      'userName': userName,
      'studentId': studentId,
      'email': email,
      'contactNo': contactNo,
      'institutionDomain': institutionDomain,
      'institutionName': institutionName,
      'degree': degree.toMap(),
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'approveDetails': approveDetails?.toMap(),
      'lastWriteAt': FieldValue.serverTimestamp()
    };
  }

  factory EducationPrvModel.fromMap(Map<String, dynamic> map) {
    return EducationPrvModel(
      docId: map['docId'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] ?? '',
      studentId: map['studentId'] as String,
      email: map['email'] as String,
      contactNo: map['contactNo'] as String,
      institutionDomain: map['institutionDomain'] as String,
      institutionName: map['institutionName'] as String,
      degree: DegreeModel.fromMap(map['degree']),
      startDate: DateTime.parse(map['startDate'] as String).toLocal(),
      endDate: map['endDate'] != null ? DateTime.tryParse(map['endDate'] as String)?.toLocal() : null,
      approveDetails: map['approveDetails'] == null ? null :  ApproveDetails.fromMap(map['approveDetails']),
      lastWriteAt: (map['lastWriteAt'] as Timestamp).toDate().toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory EducationPrvModel.fromJson(String source) => EducationPrvModel.fromMap(json.decode(source) as Map<String, dynamic>);



  EducationPrvModel copyWith({
    String? docId,
    String? userId,
    String? userName,
    String? studentId,
    String? email,
    String? contactNo,
    String? institutionDomain,
    String? institutionName,
    DegreeModel? degree,
    String? subject,
    DateTime? startDate,
    DateTime? endDate,
    ApproveDetails? approveDetails,
    bool? graduationApproved,
  }) {
    return EducationPrvModel(
      docId: docId ?? this.docId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      studentId: studentId ?? this.studentId,
      email: email ?? this.email,
      contactNo: contactNo ?? this.contactNo,
      institutionDomain: institutionDomain ?? this.institutionDomain,
      institutionName: institutionName ?? this.institutionName,
      degree: degree ?? this.degree ,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      approveDetails: approveDetails ?? this.approveDetails,
      lastWriteAt: DateTime.now()
    );
  }

  @override
  String toString() {
    return 'EducationPrivateModel(docId: $docId, userId: $userId, userName: $userName, studentId: $studentId, email: $email, contactNo: $contactNo, institutionDomain: $institutionDomain, institutionName: $institutionName, degree: $degree, startDate: $startDate, endDate: $endDate, approveDetails: $approveDetails, lastWriteAt: $lastWriteAt)';
  }

  @override
  bool operator ==(covariant EducationPrvModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docId == docId &&
      other.userId == userId &&
      other.userName == userName &&
      other.studentId == studentId &&
      other.email == email &&
      other.contactNo == contactNo &&
      other.institutionDomain == institutionDomain &&
      other.institutionName == institutionName &&
      other.degree == degree &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.approveDetails == approveDetails &&
      other.lastWriteAt == lastWriteAt;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
      userId.hashCode ^
      studentId.hashCode ^
      email.hashCode ^
      contactNo.hashCode ^
      institutionDomain.hashCode ^
      institutionName.hashCode ^
      degree.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      approveDetails.hashCode ^
      lastWriteAt.hashCode;
  }
}
