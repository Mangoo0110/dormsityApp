
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/education_private.dart';
import '../../domain/entities/education_public.dart';
import 'degree_field_of_study_model.dart';

class EducationPubModel extends EducationPub {
  @override
  final DegreeModel degree;
  EducationPubModel({
    required super.docId,
    required super.userId,
    required super.userName,
    required super.institutionDomain,
    required super.institutionName,
    required this.degree,
    required super.startDate,
    required super.endDate,
    required super.institutionApproved,
    required super.lastWriteAt,
  }): super(degree: degree);


  factory EducationPubModel.fromEntity(EducationPub educationPub) {
    return EducationPubModel(
      docId: educationPub.docId,
      userId: educationPub.userId,
      userName: educationPub.userName,
      institutionDomain: educationPub.institutionDomain,
      institutionName: educationPub.institutionName,
      degree: DegreeModel.fromEntity(educationPub.degree!),
      startDate: educationPub.startDate,
      endDate: educationPub.endDate,
      institutionApproved: educationPub.institutionApproved,
      lastWriteAt: educationPub.lastWriteAt
    );
  }

  factory EducationPubModel.fromPrivateEntity(EducationPrv educationPrv) {
    return EducationPubModel(
      docId: educationPrv.docId,
      userId: educationPrv.userId,
      userName: educationPrv.userName,
      institutionDomain: educationPrv.institutionDomain,
      institutionName: educationPrv.institutionName,
      degree: DegreeModel.fromEntity(educationPrv.degree!),
      startDate: educationPrv.startDate,
      endDate: educationPrv.endDate,
      institutionApproved: educationPrv.approveDetails != null ? true : false,
      lastWriteAt: educationPrv.lastWriteAt
    );
  }


  EducationPubModel copyWith({
    String? docId,
    String? userId,
    String? userName,
    String? institutionDomain,
    String? institutionName,
    DegreeModel? degree,
    String? subject,
    DateTime? startDate,
    DateTime? endDate,
    bool? institutionApproved,
    bool? graduationApproved,
  }) {
    return EducationPubModel(
      docId: docId ?? this.docId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      institutionDomain: institutionDomain ?? this.institutionDomain,
      institutionName: institutionName ?? this.institutionName,
      degree: degree ?? this.degree ,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      institutionApproved: institutionApproved ?? this.institutionApproved,
      lastWriteAt: DateTime.now()
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'userId': userId,
      'userName': userName,
      'institutionDomain': institutionDomain,
      'institutionName': institutionName,
      'degree': degree.toMap(),
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'institutionApproved': institutionApproved,
      'lastWriteAt': FieldValue.serverTimestamp() 
    };
  }

  factory EducationPubModel.fromMap(Map<String, dynamic> map) {
    return EducationPubModel(
      docId: map['docId'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] ?? '',
      institutionDomain: map['institutionDomain'] as String,
      institutionName: map['institutionName'] as String,
      degree: DegreeModel.fromMap(map['degree']),
      startDate: DateTime.parse(map['startDate'] as String).toLocal(),
      endDate: map['endDate'] != null ? DateTime.tryParse(map['endDate'] as String)?.toLocal() : null,
      institutionApproved: map['institutionApproved'] as bool,
      lastWriteAt: (map['lastWriteAt'] as Timestamp).toDate().toLocal(),
    );
  }
  
  @override
  bool operator ==(covariant EducationPubModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docId == docId &&
      other.userId == userId &&
      other.userName == userName &&
      other.institutionDomain == institutionDomain &&
      other.institutionName == institutionName &&
      other.degree == degree &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.institutionApproved == institutionApproved;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
      userId.hashCode ^
      institutionDomain.hashCode ^
      institutionName.hashCode ^
      degree.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      institutionApproved.hashCode;
  }
}
