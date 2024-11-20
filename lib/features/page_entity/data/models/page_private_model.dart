// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dormsity/core/common/functions/formatting.dart';

import '../../../../core/utils/classes/domain.dart';
import '../../../../core/utils/enums/page_enums.dart';
import '../../domain/entities/page_private.dart';
import '../../domain/entities/page_public.dart';

class PagePrivateModel extends PagePrivate {

  PagePrivateModel({
    required super.docId,
    required super.domain,
    required super.pageType,
    required super.public,
    required super.createdBy,
    required super.adminIds,
    required super.createdAt,
    required super.approveDetail,
  });


  

  @override
  String toString() {
    return 'Page(docId: $docId, domain: $domain, pageType: ${pageType.name}, public: $public, createdBy: $createdBy, adminIds: $adminIds, createdAt: $createdAt)';
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

  factory PagePrivateModel.fromMap(Map<String, dynamic> map) {
    return PagePrivateModel(
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


  factory PagePrivateModel.fromJson(String source) => PagePrivateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}


class ApproveDetailModel extends ApproveDetail{

  ApproveDetailModel({
    required super.approved,
    required super.deActivated,
    required super.approvedAt,
    required super.approvedBy,
    required super.deActivatedAt,
    required super.deActivatedBy,
  });

  ApproveDetailModel copyWith({
    bool? approved,
    bool? deActivated,
    DateTime? approvedAt,
    String? approvedBy,
    DateTime? deActivatedAt,
    String? deActivatedBy,
  }) {
    return ApproveDetailModel(
      approved: approved ?? this.approved,
      deActivated: deActivated ?? this.deActivated,
      approvedAt: approvedAt ?? this.approvedAt,
      approvedBy: approvedBy ?? this.approvedBy,
      deActivatedAt: deActivatedAt ?? this.deActivatedAt,
      deActivatedBy: deActivatedBy ?? this.deActivatedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'approved': approved,
      'deActivated': deActivated,
      'approvedAt': approvedAt?.toIso8601String(),
      'approvedBy': approvedBy,
      'deActivatedAt': deActivatedAt?.toIso8601String(),
      'deActivatedBy': deActivatedBy,
    };
  }

  factory ApproveDetailModel.fromMap(Map<String, dynamic> map) {
    return ApproveDetailModel(
      approved: map['approved'] ?? true,
      deActivated: map['deActivated'] ?? false,
      approvedAt: toDate(map['approvedAt']),
      approvedBy: map['approvedBy'] ?? '',
      deActivatedAt: toDate(map['deActivatedAt']),
      deActivatedBy: map['deActivatedBy'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApproveDetailModel.fromJson(String source) => ApproveDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ApproveDetailModel(approved: $approved, deActivated: $deActivated, approvedAt: $approvedAt, approvedBy: $approvedBy, deActivatedAt: $deActivatedAt, deActivatedBy: $deActivatedBy)';
  }

  @override
  bool operator ==(covariant ApproveDetailModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.approved == approved &&
      other.deActivated == deActivated &&
      other.approvedAt == approvedAt &&
      other.approvedBy == approvedBy &&
      other.deActivatedAt == deActivatedAt &&
      other.deActivatedBy == deActivatedBy;
  }

  @override
  int get hashCode {
    return approved.hashCode ^
      deActivated.hashCode ^
      approvedAt.hashCode ^
      approvedBy.hashCode ^
      deActivatedAt.hashCode ^
      deActivatedBy.hashCode;
  }
}



