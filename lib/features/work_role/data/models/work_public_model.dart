// ignore: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/work_public.dart';
import '../../../../core/utils/enums/work_type_enum.dart';

class WorkRolePubModel extends WorkRolePub {

  WorkRolePubModel({
    required super.docId,
    required super.userId,
    required super.workRole,
    required super.institutionDomain,
    required super.institutionName,
    required super.department,
    required super.startDate,
    required super.endDate,
    required super.institutionApproved,
    required super.endDateApproved,
    required super.lastWriteAt
  });


  factory WorkRolePubModel.fromEntity(WorkRolePub workRolePub) {
    return WorkRolePubModel(
      docId: workRolePub.docId,
      userId:  workRolePub.userId,
      institutionDomain: workRolePub.institutionDomain,
      institutionName: workRolePub.institutionName,
      department: workRolePub.department,
      startDate: workRolePub.startDate,
      endDate: workRolePub.endDate,
      institutionApproved: workRolePub.institutionApproved,
      endDateApproved: workRolePub.endDateApproved, 
      workRole: workRolePub.workRole,
      lastWriteAt: workRolePub.lastWriteAt
    );
  }

  
  WorkRolePubModel copyWith({
    String? docId,
    String? userId,
    String? workId,
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
    return WorkRolePubModel(
      docId: docId ?? this.docId,
      userId: userId ?? this.userId,
      workRole: workRole ?? this.workRole,
      institutionDomain: institutionDomain ?? this.institutionDomain,
      institutionName: institutionName ?? this.institutionName,
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
      'userId': userId,
      'workType': workRole.name,
      'institutionDomain': institutionDomain,
      'institutionName': institutionName,
      'department': department,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate?.toIso8601String(),
      'institutionApproved': institutionApproved,
      'endDateApproved': endDateApproved,
      'lastWriteAt': FieldValue.serverTimestamp()
    };
  }

  factory WorkRolePubModel.fromMap(Map<String, dynamic> map) {
    return WorkRolePubModel(
      docId: map['docId'] as String,
      userId: map['userId'] as String,
      workRole: WorkRole.fromMap(map['workRole'] as String),
      institutionDomain: map['institutionDomain'] as String,
      institutionName: map['institutionName'] as String,
      department: map['department'] as String,
      startDate: DateTime.parse(map['startDate'] as String).toLocal(),
      endDate: map['endDate'] != null ? DateTime.tryParse(map['endDate'] as String)?.toLocal() : null,
      institutionApproved: map['institutionApproved'] as bool,
      endDateApproved: map['endDateApproved'] as bool,
      lastWriteAt: (map['lastWriteAt'] as Timestamp).toDate().toLocal(),
    );
  }

  

  @override
  String toString() {
    return 'WorkPrv(docId: $docId, workType: $workRole, institutionDomain: $institutionDomain, institutionName: $institutionName, department: $department, startDate: $startDate, endDate: $endDate, institutionApproved: $institutionApproved, endDateApproved: $endDateApproved)';
  }

  @override
  bool operator ==(covariant WorkRolePubModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docId == docId &&
      other.userId == userId &&
      other.workRole == workRole &&
      other.institutionDomain == institutionDomain &&
      other.institutionName == institutionName &&
      other.department == department &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.institutionApproved == institutionApproved &&
      other.endDateApproved == endDateApproved;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
      userId.hashCode ^
      workRole.hashCode ^
      institutionDomain.hashCode ^
      institutionName.hashCode ^
      department.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      institutionApproved.hashCode ^
      endDateApproved.hashCode;
  }
}
