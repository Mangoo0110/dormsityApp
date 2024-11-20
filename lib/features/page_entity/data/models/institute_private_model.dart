
import 'package:flutter/foundation.dart';

import '../../../../core/common/functions/formatting.dart';
import '../../../../core/utils/enums/page_enums.dart';
import '../../domain/entities/institute_private.dart';
import 'page_private_model.dart';

class InstitutePrvModel extends InstitutePrv{
  InstitutePrvModel({
    required super.docId,
    required super.domain,
    required super.pageType,
    required super.public,
    required super.createdBy,
    required super.adminIds,
    required super.createdAt,
    required super.approveDetail,
  });

  factory InstitutePrvModel.fromEntity(InstitutePrv entity) {
    return InstitutePrvModel(
      docId: entity.docId,
      domain: entity.domain,
      public: entity.public,
      pageType: PageType.institute,
      createdBy: entity.createdBy,
      createdAt: entity.createdAt,
      approveDetail: entity.approveDetail,
      adminIds: entity.adminIds, 
    );
  }



  @override
  String toString() {
    return 'Institute page (private)(docId: $docId, domain: $domain, pageType: ${pageType.name}, public: $public, createdBy: $createdBy, adminIds: $adminIds, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant PagePrivateModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docId == docId &&
      other.domain == domain &&
      other.pageType == pageType &&
      other.public == public &&
      other.createdBy == createdBy &&
      listEquals(other.adminIds, adminIds) &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
      domain.hashCode ^
      pageType.hashCode ^
      public.hashCode ^
      createdBy.hashCode ^
      adminIds.hashCode ^
      createdAt.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'domain': domain,
      'pageType': pageType.name,
      'public': public,
      'createdBy': createdBy,
      'adminIds': adminIds,
      'createdAt': DateTime.now().toIso8601String(),
      
    };
  }

  factory InstitutePrvModel.fromMap(Map<String, dynamic> map) {
    return InstitutePrvModel(
      docId: map['docId'] ?? '',
      domain: map['domain'] != null ? map['domain'] ?? '' : null,
      pageType: PageType.fromMap(map['pageType']),
      public: map['public'] ?? false,
      createdBy: map['createdBy'] ?? '',
      adminIds: List<String>.from((map['adminIds'] as List<String>)),
      createdAt: toDate(map['createdAt']),
      approveDetail: ApproveDetailModel.fromMap(map['approveDetail']),
    );
  }
}
