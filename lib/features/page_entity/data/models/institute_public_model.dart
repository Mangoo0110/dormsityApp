
import 'package:flutter/foundation.dart';

import '../../../../core/utils/enums/page_enums.dart';
import '../../domain/entities/institute_public.dart';
import 'page_public_model.dart';

class InstitutePubModel extends InstitutePub {
  List<ChannelNameTypeModel> channelListModel;

  InstitutePubModel({
    required super.docId,
    required super.pageName,
    required super.domain,
    required super.pageType,
    required super.impression,
    required super.description,
    required super.location,
    required super.logoUrl,
    required super.public,
    required this.channelListModel,
    required super.createdBy,
    required super.adminIds,
    required super.approved,
    required super.deActivated,
  }):super(channelList: channelListModel);


  factory InstitutePubModel.fromEntity(InstitutePub entity) {
    return InstitutePubModel(
      docId: entity.docId,
      logoUrl: entity.logoUrl,
      domain: entity.domain,
      pageName: entity.pageName,
      location: entity.location,
      public: entity.public,
      pageType: PageType.institute,
      channelListModel: entity.channelList.map((e) => ChannelNameTypeModel.fromMEntity(e)).toList(),
      createdBy: entity.createdBy,
      approved: entity.approved,
      deActivated: entity.deActivated,
      adminIds: entity.adminIds, 
      impression: entity.impression, 
      description: entity.description,
    );
  }



  @override
  String toString() {
    return 'Institute(public) page(docId: $docId, pageName: $pageName, domain: $domain, pageType: ${pageType.name}, impression: $impression, description: $description, locationDetails: ${location.toString()} logoUrl: $logoUrl, public: $public, createdBy: $createdBy, adminIds: $adminIds, createdAt: $approved)';
  }

  @override
  bool operator ==(covariant InstitutePubModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docId == docId &&
      other.pageName == pageName &&
      other.domain == domain &&
      other.pageType == pageType &&
      other.impression == impression &&
      other.description == description &&
      other.logoUrl == logoUrl &&
      other.public == public &&
      other.createdBy == createdBy &&
      other.location == location &&
      listEquals(other.adminIds, adminIds) &&
      listEquals(other.channelList, channelList) &&
      other.approved == approved;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
      pageName.hashCode ^
      domain.hashCode ^
      pageType.hashCode ^
      impression.hashCode ^
      description.hashCode ^
      logoUrl.hashCode ^
      location.hashCode ^
      public.hashCode ^
      createdBy.hashCode ^
      adminIds.hashCode ^
      approved.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'pageName': pageName,
      'domain': domain,
      'pageType': pageType.name,
      'impression': impression,
      'description': description,
      'logoUrl': logoUrl,
      'public': public,
      "channelList": channelListModel.map((e)=> e.toMap()).toList(),
      'location': LocationDetailsModel.fromEntity(location).toMap(),
      'createdBy': createdBy,
      'adminIds': adminIds,
      'approved': approved,
      'deActivated': deActivated
    };
  }

  factory InstitutePubModel.fromMap(Map<String, dynamic> map) {
    return InstitutePubModel(
      docId: map['docId'] ?? '',
      pageName: map['pageName'] ?? '',
      domain: map['domain'] != null ? map['domain'] ?? '' : null,
      pageType: PageType.fromMap(map['pageType'] ?? ''),
      impression: map['impression'] ?? 0,
      description: map['description'] ?? '',
      location: map['location'] == null ? LocationDetailsModel() : LocationDetailsModel.fromMap(map['location']),
      logoUrl: map['logoUrl'] ?? '',
      public: map['public'] ?? false,
      channelListModel: map['channelList'] == null ? [] : (map['channelList'] as List<dynamic>).map((e) => ChannelNameTypeModel.fromMap(e)).toList(),
      createdBy: map['createdBy'] ?? '',
      adminIds: map['adminIds'] == null ? [] : List<String>.from((map['adminIds'])),
      approved: map["approved"] ?? true,
      deActivated: map["deActivated"] ?? true,
    );
  }
}
