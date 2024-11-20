
import '../../../../core/utils/classes/domain.dart';
import '../../domain/entities/page_private.dart';
import '../../domain/entities/page_public.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/utils/enums/page_enums.dart';
import '../../domain/entities/institute_public.dart';

class PagePublicModel extends PagePublic {

  List<ChannelNameTypeModel> channelListModel;

  PagePublicModel({
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


  factory PagePublicModel.fromEntity(InstitutePub entity) {
    return PagePublicModel(
      docId: entity.docId,
      logoUrl: entity.logoUrl,
      domain: entity.domain,
      pageName: entity.pageName,
      location: entity.location,
      public: entity.public,
      channelListModel: entity.channelList.map((e) => ChannelNameTypeModel.fromMEntity(e)).toList(),
      pageType: PageType.institute,
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
    return 'Page(public) (docId: $docId, pageName: $pageName, domain: $domain, pageType: ${pageType.name}, impression: $impression, description: $description, locationDetails: ${location.toString()} logoUrl: $logoUrl, public: $public, createdBy: $createdBy, adminIds: $adminIds, createdAt: $approved)';
  }

  @override
  bool operator ==(covariant PagePublicModel other) {
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
      channelListModel.hashCode ^
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

  factory PagePublicModel.fromMap(Map<String, dynamic> map) {
    return PagePublicModel(
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


class LocationDetailsModel extends  LocationDetail{

  LocationDetailsModel({
    super.remote,
    super.fullAddress,
    super.googleMapAddressUrl,
  });



  LocationDetailsModel copyWith({
    bool? remote,
    String? fullAddress,
    DomainUrl? googleMapAddressUrl,
  }) {
    return LocationDetailsModel(
      remote: remote ?? this.remote,
      fullAddress: fullAddress ?? this.fullAddress,
      googleMapAddressUrl: googleMapAddressUrl ?? this.googleMapAddressUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'remote': remote,
      'fullAddress': fullAddress,
      'googleMapAddressUrl': googleMapAddressUrl?.url,
    };
  }

  factory LocationDetailsModel.fromMap(Map<String, dynamic> map) {
    return LocationDetailsModel(
      remote: map['remote'] != null ? map['remote'] ?? true : null,
      fullAddress: map['fullAddress'] != null ? map['fullAddress'] as String : null,
      googleMapAddressUrl: map['googleMapAddressUrl'] != null ? DomainUrl.tryParse(map['googleMapAddressUrl'] as String) : null,
    );
  }

  factory LocationDetailsModel.fromEntity(LocationDetail entity) {
    return LocationDetailsModel(
      remote: entity.remote,
      fullAddress: entity.fullAddress,
      googleMapAddressUrl: entity.googleMapAddressUrl,
    );
  }


  @override
  String toString() => 'LocationDetails(remote: $remote, fullAddress: $fullAddress, googleMapAddressUrl: ${googleMapAddressUrl?.url})';

  @override
  bool operator ==(covariant LocationDetailsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.remote == remote &&
      other.fullAddress == fullAddress &&
      other.googleMapAddressUrl == googleMapAddressUrl;
  }

  @override
  int get hashCode => remote.hashCode ^ fullAddress.hashCode ^ googleMapAddressUrl.hashCode;
}



class ChannelNameTypeModel extends ChannelNameType{

  ChannelNameTypeModel({
    required super.channelDocId,
    required super.channelName,
    required super.channelType,
  });

  // ChannelNameTypeModel copyWith({
  //   String? channelName,
  //   ChannelType? channelType,
  // }) {
  //   return ChannelNameTypeModel(
  //     channelName: channelName ?? this.channelName,
  //     channelType: channelType ?? this.channelType,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'channelDocId': channelDocId,
      'channelName': channelName,
      'channelType': channelType.name,
    };
  }

  factory ChannelNameTypeModel.fromMap(Map<String, dynamic> map) {
    return ChannelNameTypeModel(
      channelDocId: map['channelDocId'] ?? '',
      channelName: map['channelName'] ?? '',
      channelType: ChannelType.fromMap(map['channelType'] ?? ''),
    );
  }

  factory ChannelNameTypeModel.fromMEntity(ChannelNameType entity) {
    return ChannelNameTypeModel(
      channelDocId: entity.channelDocId,
      channelName: entity.channelName,
      channelType: entity.channelType,
    );
  }

  @override
  String toString() => 'ChannelNameTypeModel(channelDocId: $channelDocId, channelName: $channelName, channelType: $channelType)';

  @override
  bool operator ==(covariant ChannelNameTypeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.channelDocId == channelDocId &&
      other.channelName == channelName &&
      other.channelType == channelType;
  }

  @override
  int get hashCode =>channelDocId.hashCode ^ channelName.hashCode ^ channelType.hashCode;
}

