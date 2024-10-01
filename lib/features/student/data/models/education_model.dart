import 'package:dormsity/features/student/domain/entities/education.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'education_model.g.dart';
part 'education_model.freezed.dart';

@Freezed()
@JsonSerializable()
class EducationModel extends Education with _$EducationModel  {

  const factory EducationModel({
    required String id, // document or data id
    required String userId,
    required String institutionDomain,
    required String institutionName,
    required String degree,
    required String subject,
    required DateTime startDate,
    required DateTime endDate,
    required bool institutionApproved,
    required bool graduationApproved,
  }) = _EducationModel;


  factory EducationModel.fromJson({required Map<String, dynamic> json})
      => _$EducationModelFromJson(json);
}
