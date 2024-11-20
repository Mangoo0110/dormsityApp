import '../../../../core/utils/enums/page_enums.dart';
import 'page_private.dart';

class PagePublic {
  final String docId;
  String pageName;
  String domain;
  final PageType pageType;
  final int impression;
  String description;
  String logoUrl;
  bool public;
  final bool approved;
  final bool deActivated;
  final LocationDetail location;

  final List<ChannelNameType> channelList;
  /// User's uid.
  final String createdBy;

  ///List of uid of users.
  final List<String> adminIds;

  PagePublic({
    required this.docId,
    required this.pageName,
    required this.domain,
    required this.pageType,
    required this.impression,
    required this.description,
    required this.location,
    required this.logoUrl,
    required this.public,
    required this.channelList,
    required this.createdBy,
    required this.adminIds,
    required this.approved,
    required this.deActivated,
  });
}

class ChannelNameType{
  final String channelDocId;
  final String channelName;
  final ChannelType channelType;

  ChannelNameType({required this.channelName, required this.channelDocId, required this.channelType});
}


