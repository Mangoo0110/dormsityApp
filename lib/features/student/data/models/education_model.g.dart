// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EducationModel _$EducationModelFromJson(Map<String, dynamic> json) =>
    EducationModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      institutionDomain: json['institutionDomain'] as String,
      institutionName: json['institutionName'] as String,
      degree: json['degree'] as String,
      subject: json['subject'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      institutionApproved: json['institutionApproved'] as bool,
      graduationApproved: json['graduationApproved'] as bool,
    );

Map<String, dynamic> _$EducationModelToJson(EducationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'institutionDomain': instance.institutionDomain,
      'institutionName': instance.institutionName,
      'degree': instance.degree,
      'subject': instance.subject,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'institutionApproved': instance.institutionApproved,
      'graduationApproved': instance.graduationApproved,
    };

_$EducationModelImpl _$$EducationModelImplFromJson(Map<String, dynamic> json) =>
    _$EducationModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      institutionDomain: json['institutionDomain'] as String,
      institutionName: json['institutionName'] as String,
      degree: json['degree'] as String,
      subject: json['subject'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      institutionApproved: json['institutionApproved'] as bool,
      graduationApproved: json['graduationApproved'] as bool,
    );

Map<String, dynamic> _$$EducationModelImplToJson(
        _$EducationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'institutionDomain': instance.institutionDomain,
      'institutionName': instance.institutionName,
      'degree': instance.degree,
      'subject': instance.subject,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'institutionApproved': instance.institutionApproved,
      'graduationApproved': instance.graduationApproved,
    };
