// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

import '../../../../core/utils/enums/complain_enum.dart';

class Complain {
  final String docId;
  final String userId;
  final String studentId;
  final String dormitoryId;
  final String dormitoryName;
  final String content;
  final List<String> imageIdList;
  final ComplainType complainType;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Complain({
    required this.docId,
    required this.userId,
    required this.studentId,
    required this.dormitoryId,
    required this.dormitoryName,
    required this.content,
    required this.imageIdList,
    required this.complainType,
    required this.createdAt,
    required this.updatedAt,
  });


  Complain copyWith({
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
    return Complain(
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

  @override
  String toString() {
    return 'ComplainModel(docId: $docId, userId: $userId, studentId: $studentId, dormitoryId: $dormitoryId, dormitoryName: $dormitoryName, content: $content, imageIdList: $imageIdList, complainType: $complainType, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Complain other) {
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
