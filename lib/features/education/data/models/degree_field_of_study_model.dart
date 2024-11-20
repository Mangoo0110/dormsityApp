// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../domain/entities/degree_field_of_study.dart';

class DegreeModel extends Degree {

  DegreeModel({
    required super.docId,
    required super.institutionDomain,
    required super.degree,
    required super.fieldOfStudy,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'institutionDomain': institutionDomain,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy
    };
  }

  factory DegreeModel.fromMap(Map<String, dynamic> map) {
    return DegreeModel(
      docId: map['docId'] as String,
      institutionDomain: map['institutionDomain'] as String,
      degree: map['degree'] as String,
      fieldOfStudy: map['fieldOfStudy'] as String,
    );
  }


  factory DegreeModel.fromEntity(Degree degree) {
    return DegreeModel(
      docId: degree.docId,
      institutionDomain: degree.institutionDomain,
      degree: degree.degree,
      fieldOfStudy: degree.fieldOfStudy,
    );
  }

  String toJson() => json.encode(toMap());

  factory DegreeModel.fromJson(String source) => DegreeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DegreeModel(docId: $docId, degree: $degree)';

  @override
  bool operator ==(covariant DegreeModel other) {
    if (identical(this, other)) return true;

    return
      other.docId == docId &&
      other.institutionDomain == institutionDomain &&
      other.fieldOfStudy == fieldOfStudy &&
      other.degree == degree;
  }

  @override
  int get hashCode => docId.hashCode ^ degree.hashCode;
}

