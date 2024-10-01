import '../../../../../core/utils/constants/data_field_key_names.dart';
import '../../domain/entities/complain.dart';

class ComplainModel extends Complain {

  ComplainModel({
    required super.id,
    required super.studentId,
    required super.dormitoryId,
    required super.dormitoryName,
    required super.content,
    required super.imageIdList,
    required super.complainType,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ComplainModel.fromMap({required Map<String, dynamic> map}){
    return ComplainModel(
      id: map[kid] ?? '', 
      studentId: map[kstudentId] ?? '', 
      dormitoryId: map[kdormitoryId] ?? '', 
      dormitoryName: map[kdormitoryName] ?? '', 
      content: map[kcontent] ?? '', 
      imageIdList: map[kimageIdList] ?? [], 
      complainType: map[kcomplainType] == null ? ComplainType.relatable
          : map[kcomplainType] == ComplainType.harassment.name ? ComplainType.harassment
          : map[kcomplainType] == ComplainType.relatable.name ? ComplainType.relatable
          : ComplainType.room,
      createdAt: map[kcreatedAt] == null ? DateTime.now() : DateTime.parse(map[kcreatedAt]),
      updatedAt: map[kupdatedAt] == null ? DateTime.now() : DateTime.parse(map[kcreatedAt]),
    );
  }

  factory ComplainModel.fromEntity(Complain complain){
    return ComplainModel(
      id: complain.id, 
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


  Map<String, dynamic> toMap(){
    return {
      kid: id,
      kstudentId: studentId,
      kdormitoryId: dormitoryId,
      kdormitoryName: dormitoryName,
      kcontent: content,
      kimageIdList: imageIdList,
      kcomplainType: complainType.name,
      kcreatedAt: createdAt.toIso8601String(),
      kupdatedAt: updatedAt.toIso8601String(),
    };
  }
}