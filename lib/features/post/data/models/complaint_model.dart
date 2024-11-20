

import 'package:flutter/foundation.dart';

import '../../../../core/common/functions/formatting.dart';
import '../../../../core/utils/enums/page_enums.dart';
import '../../domain/entities/complaint.dart';
import '../../domain/entities/post.dart';
import 'post_model.dart';

class ComplaintModel extends Complaint{

  ComplaintModel({
    required super.complaintStatusList,
    required super.post,
  });
  

  ComplaintModel copyWith({
    List<ComplaintStatus>? complaintStatusList,
    Post? post,
  }) {
    return ComplaintModel(
      complaintStatusList: complaintStatusList ?? this.complaintStatusList,
      post: post ?? this.post,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'complaintStatusList': complaintStatusList.map((e) => ComplaintStatusModel.fromEntity(e).toMap()).toList(),
      'post': PostModel.fromEntity(post),
    };
  }

  factory ComplaintModel.fromMap(Map<String, dynamic> map) {
    return ComplaintModel(
      complaintStatusList: (map['complaintStatusList'] as List<dynamic>).map((dataRaw) =>  ComplaintStatusModel.fromEntity(dataRaw),).toList(),
      post: PostModel.fromMap(map['post'] as Map<String,dynamic>),
    );
  }


  @override
  String toString() => 'ComplaintModel(complaintStatusList: ${complaintStatusList.map((e) => ComplaintStatusModel.fromEntity(e).toMap()).toList()}, post: ${post.toString()})';

  @override
  bool operator ==(covariant ComplaintModel other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.complaintStatusList, complaintStatusList) &&
      other.post == post;
  }

  @override
  int get hashCode => complaintStatusList.hashCode ^ post.hashCode;

}




class ComplaintStatusModel extends ComplaintStatus {

  ComplaintStatusModel({
    required super.statusDetailDocId,
    required super.complaintTag,
    required super.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusDetailDocId': statusDetailDocId,
      'complaintTag': complaintTag.name,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory ComplaintStatusModel.fromMap(Map<String, dynamic> map) {
    return ComplaintStatusModel(
      statusDetailDocId: map['statusDetailDocId'] as String,
      complaintTag: ComplaintTag.fromMap(map['complaintTag'] as String),
      createdAt: toDate(map['createdAt'] as dynamic),
    );
  }

  factory ComplaintStatusModel.fromEntity(ComplaintStatus entity) {
    return ComplaintStatusModel(
      statusDetailDocId: entity.statusDetailDocId,
      complaintTag: entity.complaintTag,
      createdAt: entity.createdAt,
    );
  }


  @override
  String toString() => 'ComplaintStatus(statusDetailDocId: $statusDetailDocId, complaintTag: $complaintTag, createdAt: $createdAt)';

  @override
  bool operator ==(covariant ComplaintStatus other) {
    if (identical(this, other)) return true;
  
    return 
      other.statusDetailDocId == statusDetailDocId &&
      other.complaintTag == complaintTag &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode => statusDetailDocId.hashCode ^ complaintTag.hashCode ^ createdAt.hashCode;
}


