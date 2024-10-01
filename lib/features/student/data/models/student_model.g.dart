// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'email': instance.email,
      'contactNo': instance.contactNo,
      'institutionDomain': instance.institutionDomain,
      'institutionName': instance.institutionName,
      'degree': instance.degree,
      'subject': instance.subject,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'institutionApproved': instance.institutionApproved,
      'graduationApproved': instance.graduationApproved,
    };

_$StudentModelImpl _$$StudentModelImplFromJson(Map<String, dynamic> json) =>
    _$StudentModelImpl(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      email: json['email'] as String,
      contactNo: json['contactNo'] as String,
      institutionDomain: json['institutionDomain'] as String,
      institutionName: json['institutionName'] as String,
      degree: json['degree'] as String,
      subject: json['subject'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      institutionApproved: json['institutionApproved'] as bool,
      graduationApproved: json['graduationApproved'] as bool,
    );

Map<String, dynamic> _$$StudentModelImplToJson(_$StudentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'email': instance.email,
      'contactNo': instance.contactNo,
      'institutionDomain': instance.institutionDomain,
      'institutionName': instance.institutionName,
      'degree': instance.degree,
      'subject': instance.subject,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'institutionApproved': instance.institutionApproved,
      'graduationApproved': instance.graduationApproved,
    };
