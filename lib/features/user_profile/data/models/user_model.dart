

import '../../../../core/utils/constants/data_field_key_names.dart';
import '../../domain/entities/app_user.dart';

class UserModel extends AppUser {
  UserModel({
    required super.id,
    required super.email,
    required super.fullName,
    required super.joinedAt,
    required super.imageId,
    required super.profession, required super.country, required super.contactNo,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[kid] ?? '',
      email: map[kemail] ?? '',
      country: map[kcountry] ?? '',
      contactNo: map[kcontactNo] ?? '',
      fullName: map[kfullName] ?? '',
      joinedAt: map[kjoinedAt] == null ? DateTime.now() : DateTime.tryParse(map[kjoinedAt].toString())?? DateTime.now(),
      imageId: map[kimageId] ?? '',
      profession: map[kprofession] ?? '',
    );
  }

  factory UserModel.fromEntity(AppUser user) {
    return UserModel(
      id: user.id,
      email:user.email,
      country: user.country,
      contactNo: user.contactNo,
      fullName: user.fullName,
      joinedAt: user.joinedAt,
      imageId: user.imageId,
      profession: user.profession,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      kid: id,
      kemail: email,
      kcountry: country,
      kcontactNo: contactNo,
      kfullName: fullName,
      kjoinedAt: joinedAt,
      kimageId: imageId,
      kprofession: profession
    };
  }

}