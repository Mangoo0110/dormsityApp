// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/work_private.dart';

import '../../../../core/utils/enums/work_type_enum.dart';

class WorkRolePrvModel extends WorkRolePrv {

  WorkRolePrvModel({
    required super.docId,
    required super.userId,
    required super.workId,
    required super.workRole,
    required super.institutionDomain,
    required super.institutionName,
    required super.email,
    required super.contactNo,
    required super.department,
    required super.startDate,
    required super.endDate,
    required super.institutionApproved,
    required super.endDateApproved,
    required super.lastWriteAt
  });

  
  WorkRolePrvModel copyWith({
    String? docId,
    String? workId,
    String? userId,
    WorkRole? workRole,
    String? institutionDomain,
    String? institutionName,
    String? email,
    String? contactNo,
    String? department,
    DateTime? startDate,
    DateTime? endDate,
    bool? institutionApproved,
    bool? endDateApproved,
  }) {
    return WorkRolePrvModel(
      docId: docId ?? this.docId,
      userId: userId ?? this.userId,
      workId: workId ?? this.workId,
      workRole: workRole ?? this.workRole,
      institutionDomain: institutionDomain ?? this.institutionDomain,
      institutionName: institutionName ?? this.institutionName,
      email: email ?? this.email,
      contactNo: contactNo ?? this.contactNo,
      department: department ?? this.department,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      institutionApproved: institutionApproved ?? this.institutionApproved,
      endDateApproved: endDateApproved ?? this.endDateApproved,
      lastWriteAt: DateTime.now()
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'workId': workId,
      'workRole': workRole.name,
      'institutionDomain': institutionDomain,
      'institutionName': institutionName,
      'email': email,
      'contactNo': contactNo,
      'department': department,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'institutionApproved': institutionApproved,
      'endDateApproved': endDateApproved,
      'lastWriteAt': FieldValue.serverTimestamp()
    };
  }

  factory WorkRolePrvModel.fromMap(Map<String, dynamic> map) {
    return WorkRolePrvModel(
      docId: map['docId'] as String,
      userId: map['userId'] as String,
      workId: map['workId'] as String,
      workRole: WorkRole.fromMap(map['workRole'] as String),
      institutionDomain: map['institutionDomain'] as String,
      institutionName: map['institutionName'] as String,
      email: map['email'] as String,
      contactNo: map['contactNo'] as String,
      department: map['department'] as String,
      startDate: DateTime.parse(map['startDate'] as String).toLocal(),
      endDate: map['endDate'] != null ? DateTime.tryParse(map['endDate'] as String)?.toLocal() : null,
      institutionApproved: map['institutionApproved'] as bool,
      endDateApproved: map['endDateApproved'] as bool,
      lastWriteAt: (map['lastWriteAt'] as Timestamp).toDate().toLocal(),
    );
  }

  factory WorkRolePrvModel.fromEntity(WorkRolePrv workRolePrv) {
    return WorkRolePrvModel(
      docId: workRolePrv.docId,
      userId: workRolePrv.userId,
      workId: workRolePrv.workId,
      workRole: workRolePrv.workRole,
      institutionDomain: workRolePrv.institutionDomain,
      institutionName: workRolePrv.institutionName,
      email: workRolePrv.email,
      contactNo:workRolePrv.contactNo,
      department: workRolePrv.department,
      startDate: workRolePrv.startDate,
      endDate: workRolePrv.endDate,
      institutionApproved: workRolePrv.institutionApproved,
      endDateApproved: workRolePrv.endDateApproved,
      lastWriteAt: workRolePrv.lastWriteAt
    );
  }

  @override
  String toString() {
    return 'WorkPrv(id: $docId, workId: $workId, workType: $workRole, institutionDomain: $institutionDomain, institutionName: $institutionName, email: $email, contactNo: $contactNo, department: $department, startDate: $startDate, endDate: $endDate, institutionApproved: $institutionApproved, endDateApproved: $endDateApproved, lastWriteAt: $lastWriteAt)';
  }

  @override
  bool operator ==(covariant WorkRolePrvModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docId == docId &&
      other.workId == workId &&
      other.workRole == workRole &&
      other.institutionDomain == institutionDomain &&
      other.institutionName == institutionName &&
      other.email == email &&
      other.contactNo == contactNo &&
      other.department == department &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.institutionApproved == institutionApproved &&
      other.endDateApproved == endDateApproved &&
      other.lastWriteAt == lastWriteAt;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
      workId.hashCode ^
      workRole.hashCode ^
      institutionDomain.hashCode ^
      institutionName.hashCode ^
      email.hashCode ^
      contactNo.hashCode ^
      department.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      institutionApproved.hashCode ^
      lastWriteAt.hashCode ^
      endDateApproved.hashCode;
  }
}
