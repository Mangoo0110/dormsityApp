import 'package:flutter/foundation.dart';

import '../../../../core/utils/enums/complain_enum.dart';
import '../../domain/entities/complain.dart';

class ComplainModel extends Complain {

  ComplainModel({
    required super.docId,
    required super.userId,
    required super.studentId,
    required super.dormitoryId,
    required super.dormitoryName,
    required super.content,
    required super.imageIdList,
    required super.complainType,
    required super.createdAt,
    required super.updatedAt,
  });


  factory ComplainModel.fromEntity(Complain complain){
    return ComplainModel(
      docId: complain.docId, 
      userId: complain.userId,
      studentId: complain.studentId, 
      dormitoryId: complain.dormitoryId, 
      dormitoryName: complain.dormitoryName, 
      content: complain.content, 
      imageIdList: complain.imageIdList, 
      complainType: complain.complainType,
      createdAt: complain.createdAt,
      updatedAt: complain.updatedAt
    );
  }

  @override
  ComplainModel copyWith({
    String? docId,
    String? userId,
    String? studentId,
    String? dormitoryId,
    String? dormitoryName,
    String? content,
    List<String>? imageIdList,
    ComplainType? complainType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ComplainModel(
      docId: docId ?? this.docId,
      userId: userId ?? this.userId,
      studentId: studentId ?? this.studentId,
      dormitoryId: dormitoryId ?? this.dormitoryId,
      dormitoryName: dormitoryName ?? this.dormitoryName,
      content: content ?? this.content,
      imageIdList: imageIdList ?? this.imageIdList,
      complainType: complainType ?? this.complainType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'userId': userId,
      'studentId': studentId,
      'dormitoryId': dormitoryId,
      'dormitoryName': dormitoryName,
      'content': content,
      'imageIdList': imageIdList,
      'complainType': complainType.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory ComplainModel.fromMap(Map<String, dynamic> map) {
    return ComplainModel(
      docId: map['docId'] as String,
      userId: map['userId'] as String,
      studentId: map['studentId'] as String,
      dormitoryId: map['dormitoryId'] as String,
      dormitoryName: map['dormitoryName'] as String,
      content: map['content'] as String,
      imageIdList: List<String>.from((map['imageIdList'] as List<String>)),
      complainType: ComplainType.fromMap(map['complainType'] as String),
      createdAt: DateTime.tryParse(map['createdAt'] as String) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updatedAt'] as String),
    );
  }

  @override
  String toString() {
    return 'ComplainModel(docId: $docId, userId: $userId, studentId: $studentId, dormitoryId: $dormitoryId, dormitoryName: $dormitoryName, content: $content, imageIdList: $imageIdList, complainType: $complainType, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ComplainModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docId == docId &&
      other.userId == userId &&
      other.studentId == studentId &&
      other.dormitoryId == dormitoryId &&
      other.dormitoryName == dormitoryName &&
      other.content == content &&
      listEquals(other.imageIdList, imageIdList) &&
      other.complainType == complainType &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
      userId.hashCode ^
      studentId.hashCode ^
      dormitoryId.hashCode ^
      dormitoryName.hashCode ^
      content.hashCode ^
      imageIdList.hashCode ^
      complainType.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}