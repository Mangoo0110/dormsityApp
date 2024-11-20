

import '../../../../core/common/functions/formatting.dart';
import '../../domain/entities/channel.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/utils/enums/page_enums.dart';

class ChannelModel extends Channel{

  ChannelModel({
    required super.docId,
    required super.pageId,
    required super.channelName,
    required super.channelType,
    required super.impression,
    required super.description,
    required super.logoUrl,
    required super.public,
    required super.createdBy,
    required super.adminIds,
    required super.postCount,
    required super.follwersCount,
    required super.createdAt
  });



  

  @override
  bool operator ==(covariant ChannelModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docId == docId &&
      other.pageId == pageId &&
      other.channelName == channelName &&
      other.impression == impression &&
      other.description == description &&
      other.logoUrl == logoUrl &&
      other.public == public &&
      other.follwersCount == follwersCount &&
      other.postCount == postCount &&
      other.createdBy == createdBy &&
      listEquals(other.adminIds, adminIds) &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
      pageId.hashCode ^
      channelName.hashCode ^
      impression.hashCode ^
      description.hashCode ^
      logoUrl.hashCode ^
      public.hashCode ^
      follwersCount.hashCode ^
      postCount.hashCode ^
      createdBy.hashCode ^
      adminIds.hashCode ^
      createdAt.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'pageId': pageId,
      'channelName': channelName,
      'impression': impression,
      'description': description,
      'logoUrl': logoUrl,
      'public': public,
      'follwersCount': follwersCount,
      'postCount': postCount,
      'createdBy': createdBy,
      'adminIds': adminIds,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory ChannelModel.fromMap(Map<String, dynamic> map) {
    return ChannelModel(
      docId: map['docId'] ?? '',
      pageId: map['pageId'] ?? '',
      channelType: ChannelType.fromMap(map['channelType'] ?? ''),
      channelName: map['channelName'] ?? '',
      impression: map['impression'] ?? 0,
      description: map['description'] ?? '',
      logoUrl: map['logoUrl'] ?? '',
      public: map['public'] ?? true,
      follwersCount: map['follwersCount'] ?? 0,
      postCount: map['postCount'] ?? 0,
      createdBy: map['createdBy'] ?? '',
      adminIds: [],//map['adminIds'] == null ? [] : List<String>.from((map['adminIds'] as List<dynamic>).map((e) => e.toString()).toList()),
      createdAt: toDate(map['createdAt']) ?? DateTime.now()
    );
  }

  factory ChannelModel.fromEntity(Channel entity) {
    return ChannelModel(
      docId: entity.docId,
      pageId: entity.pageId,
      channelType: entity.channelType,
      channelName: entity.channelName,
      impression: entity.impression,
      description: entity.description,
      logoUrl: entity.logoUrl,
      public: entity.public,
      follwersCount: entity.follwersCount,
      postCount: entity.postCount,
      createdBy: entity.createdBy,
      adminIds: entity.adminIds,
      createdAt: entity.createdAt
    );
  }

  @override
  String toString() {
    return 'Channel model(docId: $docId, pageId: $pageId, channelName: $channelName, impression: $impression, description: $description, logoUrl: $logoUrl, public: $public, follwersCount: $follwersCount, postCount: $postCount, createdBy: $createdBy, adminIds: $adminIds, createdAt: $createdAt)';
  }
}
