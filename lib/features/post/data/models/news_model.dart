

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:dormsity/core/utils/enums/page_enums.dart';

import '../../../../core/common/functions/formatting.dart';
import '../../domain/entities/news.dart';
import '../../domain/entities/post.dart';

class NewsModel extends News{
  
  NewsModel({
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

  NewsModel copyWith({
    String? docId,
    PostMetaDataModel? postMetaData,
    PostType? postType,
    String? createdBy,
    DateTime? createdAt,
    DateTime? lastEditAt,
    String? textContent,
    List<String>? imageContentUrls,
    int? upVote,
    int? impression,
    int? commentCount,
  }) {
    return NewsModel(
      docId: docId ?? this.docId,
      postMetaData: postMetaData ?? this.postMetaData,
      postType: postType ?? this.postType,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      lastEditAt: lastEditAt ?? this.lastEditAt,
      textContent: textContent ?? this.textContent,
      imageContentUrls: imageContentUrls ?? this.imageContentUrls,
      upVote: upVote ?? this.upVote,
      impression: impression ?? this.impression,
      commentCount: commentCount ?? this.commentCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'postMetaData': PostMetaDataModel.fromEntity(postMetaData).toMap(),
      'postType': postType.name,
      'createdBy': createdBy,
      'createdAt': FieldValue.serverTimestamp(),
      'lastEditAt': FieldValue.serverTimestamp(),
      'textContent': textContent,
      'imageContentUrls': imageContentUrls,
      'upVote': upVote,
      'impression': impression,
      'commentCount': commentCount,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      docId: map['docId'] as String,
      postMetaData: PostMetaDataModel.fromMap(map['postMetaData'] as dynamic),
      postType: PostType.fromMap(map['postType'] as String),
      createdBy: map['createdBy'] as String,
      createdAt: toDate(map['createdAt'] as dynamic),
      lastEditAt: toDate(map['lastEditAt'] as dynamic),
      textContent: map['textContent'] as String,
      imageContentUrls: List<String>.from((map['imageContentUrls'])),
      upVote: map['upVote'] as int,
      impression: map['impression'] as int,
      commentCount: map['commentCount'] as int,
    );
  }

  factory NewsModel.fromEntity(Post post) {
    return NewsModel(
      docId: post.docId,
      postMetaData: PostMetaDataModel.fromEntity(post.postMetaData),
      postType: post.postType,
      createdBy: post.createdBy,
      createdAt: post.createdAt,
      lastEditAt: post.lastEditAt,
      textContent: post.textContent,
      imageContentUrls: post.imageContentUrls,
      upVote: post.upVote,
      impression: post.impression,
      commentCount: post.commentCount,
    );
  }

  @override
  String toString() {
    return 'News post(docId: $docId, channelId: $postMetaData, postType: $postType, createdBy: $createdBy, createdAt: $createdAt, lastEditAt: $lastEditAt, textContent: $textContent, imageContentUrls: $imageContentUrls, upVote: $upVote, impression: $impression, commentCount: $commentCount, upVoted: $upVoted, downVoted: $downVoted)';
  }

  @override
  bool operator ==(covariant NewsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docId == docId &&
      other.postMetaData == postMetaData &&
      other.postType == postType &&
      other.createdBy == createdBy &&
      other.createdAt == createdAt &&
      other.lastEditAt == lastEditAt &&
      other.textContent == textContent &&
      listEquals(other.imageContentUrls, imageContentUrls) &&
      other.upVote == upVote &&
      other.impression == impression &&
      other.commentCount == commentCount;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
      postMetaData.hashCode ^
      postType.hashCode ^
      createdBy.hashCode ^
      createdAt.hashCode ^
      lastEditAt.hashCode ^
      textContent.hashCode ^
      imageContentUrls.hashCode ^
      upVote.hashCode ^
      impression.hashCode ^
      commentCount.hashCode;
  }
}



class PostMetaDataModel extends PostMetaData{
  
  PostMetaDataModel({
    required super.createdAt,
    required super.channelDocId,
    required super.channelName,
    required super.channelType,
    required super.pageDocId,
    required super.pageName,
    required super.pageLogoUrl,
  });

  @override
  String toString() {
    return 'PostMetaData(createdAt: $createdAt, channelDocId: $channelDocId, channelName: $channelName, channelType: $channelType, pageDocId: $pageDocId, pageName: $pageName, pageLogoUrl: $pageLogoUrl)';
  }

  @override
  bool operator ==(covariant PostMetaDataModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.createdAt == createdAt &&
      other.channelDocId == channelDocId &&
      other.channelName == channelName &&
      other.channelType == channelType &&
      other.pageDocId == pageDocId &&
      other.pageName == pageName &&
      other.pageLogoUrl == pageLogoUrl;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
      channelDocId.hashCode ^
      channelName.hashCode ^
      channelType.hashCode ^
      pageDocId.hashCode ^
      pageName.hashCode ^
      pageLogoUrl.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': FieldValue.serverTimestamp(),
      'channelDocId': channelDocId,
      'channelName': channelName,
      'channelType': channelType.name,
      'pageDocId': pageDocId,
      'pageName': pageName,
      'pageLogoUrl': pageLogoUrl,
    };
  }

  factory PostMetaDataModel.fromMap(Map<String, dynamic> map) {
    return PostMetaDataModel(
      createdAt: toDate(map['createdAt'] ),
      channelDocId: map['channelDocId'] as String,
      channelName: map['channelName'] as String,
      channelType: ChannelType.fromMap(map['channelType'] as String),
      pageDocId: map['pageDocId'] as String,
      pageName: map['pageName'] as String,
      pageLogoUrl: map['pageLogoUrl'] as String,
    );
  }

  factory PostMetaDataModel.fromEntity(PostMetaData entity) {
    return PostMetaDataModel(
      createdAt: entity.createdAt,
      channelDocId: entity.channelDocId,
      channelName: entity.channelName,
      channelType: entity.channelType,
      pageDocId: entity.pageDocId,
      pageName: entity.pageName,
      pageLogoUrl: entity.pageLogoUrl,
    );
  }

}
