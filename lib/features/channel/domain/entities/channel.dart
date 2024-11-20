import 'package:flutter/foundation.dart';

import '../../../../core/utils/enums/page_enums.dart';

class Channel {
  final String docId;
  final String pageId;
  final String channelName;
  ChannelType channelType;
  final int impression;
  final String description;
  final String logoUrl;
  final bool public;
  final int follwersCount;
  final int postCount;
  /// User's uid.
  final String createdBy;

  ///List of uid of users.
  List<String> adminIds;
  final DateTime createdAt;

  Channel({
    required this.docId,
    required this.pageId,
    required this.channelName,
    required this.channelType,
    required this.impression,
    required this.description,
    required this.logoUrl,
    required this.public,
    required this.createdBy,
    required this.adminIds,
    required this.postCount,
    required this.follwersCount,
    required this.createdAt
  });



  

  @override
  bool operator ==(covariant Channel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docId == docId &&
      other.pageId == pageId &&
      other.channelName == channelName &&
      other.channelType == channelType &&
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
      channelType.hashCode ^
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
}
