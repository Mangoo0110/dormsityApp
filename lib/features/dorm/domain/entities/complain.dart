// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/foundation.dart';

enum ComplainType { harassment, room, relatable }

class Complain {
  final String id;
  final String studentId;
  final String dormitoryId;
  final String dormitoryName;
  final String content;
  final List<String> imageIdList;
  final ComplainType complainType;
  final DateTime createdAt;
  final DateTime updatedAt;

  Complain({
    required this.id,
    required this.studentId,
    required this.dormitoryId,
    required this.dormitoryName,
    required this.content,
    required this.imageIdList,
    required this.complainType,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  int get hashCode {
    return id.hashCode ^
        studentId.hashCode ^
        dormitoryId.hashCode ^
        dormitoryName.hashCode ^
        content.hashCode ^
        imageIdList.hashCode ^
        complainType.hashCode;
  }

  @override
  bool operator ==(covariant Complain other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.studentId == studentId &&
        other.dormitoryId == dormitoryId &&
        other.dormitoryName == dormitoryName &&
        other.content == content &&
        listEquals(other.imageIdList, imageIdList) &&
        other.complainType == complainType;
  }
}