import '../../../../core/utils/enums/page_enums.dart';
import 'post.dart';

class Complaint{
  final List<ComplaintStatus> complaintStatusList;
  final Post post;

  Complaint({required this.complaintStatusList, required this.post});
  
}

class ComplaintStatus {
  final String statusDetailDocId;
  final ComplaintTag complaintTag;
  final DateTime? createdAt;

  ComplaintStatus({
    required this.statusDetailDocId,
    required this.complaintTag,
    required this.createdAt,
  });
}



