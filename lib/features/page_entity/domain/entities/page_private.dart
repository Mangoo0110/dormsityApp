import '../../../../core/utils/classes/domain.dart';
import '../../../../core/utils/enums/page_enums.dart';

class PagePrivate {
  final String docId;
  String? domain;
  final PageType pageType;
  bool public;
  final ApproveDetail approveDetail;

  /// User's uid.
  final String createdBy;

  ///List of uid of users.
  final List<String> adminIds;
  final DateTime? createdAt;

  PagePrivate({
    required this.docId,
    required this.domain,
    required this.pageType,
    required this.public,
    required this.createdBy,
    required this.adminIds,
    required this.createdAt,
    required this.approveDetail,
  });
}



class LocationDetail {
  bool? remote;
  String? fullAddress;
  DomainUrl? googleMapAddressUrl;

  LocationDetail({
    this.remote,
    this.fullAddress,
    this.googleMapAddressUrl,
  });
}

class ApproveDetail {
  final bool approved;
  final bool deActivated;
  final DateTime? approvedAt;
  final String approvedBy;
  final DateTime? deActivatedAt;
  final String deActivatedBy;

  ApproveDetail({
    required this.approved,
    required this.deActivated,
    required this.approvedAt,
    required this.approvedBy,
    required this.deActivatedAt,
    required this.deActivatedBy,
  });
}
