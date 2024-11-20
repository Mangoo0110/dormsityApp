// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/foundation.dart';

// import '../../../../core/utils/enums/page_enums.dart';

// class ChannelPrivate {
//   final String docId;
//   final String hubName;
//   final ChannelType channelType;
//   final int impression;
//   final String description;
//   /// User's uid.
//   final String creator;

//   ///List of uid of users.
//   final List<String> adminIds;
//   final DateTime createdAt;

//   ChannelPrivate({
//     required this.docId,
//     required this.hubName,
//     required this.channelType,
//     required this.impression,
//     required this.description,
//     required this.logoUrl,
//     required this.institutionDomain,
//     required this.public,
//     required this.creator,
//     required this.adminIds,
//     required this.postCount,
//     required this.follwersCount,
//     required this.createdAt
//   });



//   @override
//   bool operator ==(covariant ChannelPrivate other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.docId == docId &&
//       other.hubName == hubName &&
//       other.description == description &&
//       other.institutionDomain == institutionDomain &&
//       other.createdAt == createdAt &&
//       other.creator == creator &&
//       other.logoUrl == logoUrl &&
//       listEquals(other.adminIds, adminIds);
//   }

//   @override
//   int get hashCode {
//     return docId.hashCode ^
//       hubName.hashCode ^
//       description.hashCode ^
//       institutionDomain.hashCode ^
//       createdAt.hashCode ^
//       creator.hashCode ^
//       logoUrl.hashCode ^
//       adminIds.hashCode;
//   }
// }
