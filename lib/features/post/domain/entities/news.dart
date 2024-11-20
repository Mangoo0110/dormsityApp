import 'post.dart';

class News extends Post {
  
  News({
    
    required super.docId,
    required super.postMetaData,
    required super.postType,
    required super.createdBy,
    required super.createdAt,
    required super.lastEditAt,
    required super.textContent,
    required super.imageContentUrls,
    required super.upVote,
    required super.impression,
    required super.commentCount,
  });
  
}
