
import '../../../../core/utils/enums/page_enums.dart';
import '../../domain/entities/complaint_status_detail.dart';
import 'post_model.dart';

class ComplaintStatusDetailModel extends ComplaintStatusDetail {
  
  ComplaintStatusDetailModel({
    required super.docId,
    required super.currentTag,
    required PostModel post,
  }): super(post: post);



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'currentTag': currentTag.name,
      'post': PostModel.fromEntity(post),
    };
  }

  factory ComplaintStatusDetailModel.fromMap(Map<String, dynamic> map) {
    return ComplaintStatusDetailModel(
      docId: map['docId'] as String,
      currentTag: ComplaintTag.fromMap(map['currentTag'] as String),
      post: PostModel.fromMap(map['post'] as Map<String,dynamic>),
    );
  }

  @override
  String toString() => 'ComplaintStatusDetailModel(docId: $docId, currentTag: $currentTag, post: ${post.toString()})';

  @override
  bool operator ==(covariant ComplaintStatusDetailModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docId == docId &&
      other.currentTag == currentTag &&
      other.post == post;
  }

  @override
  int get hashCode => docId.hashCode ^ currentTag.hashCode ^ post.hashCode;
}



