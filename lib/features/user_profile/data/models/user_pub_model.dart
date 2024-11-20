

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/utils/enums/common_enums.dart';
import '../../domain/entities/user_prv.dart';
import '../../domain/entities/user_pub.dart';

class UserPubModel extends UserPub {
  UserPubModel({
    required super.docId,
    required super.fullName,
    required super.imageUrl,
    required super.about, 
    required super.birthdate,
    required super.gender,
    required super.country,
  });

  factory UserPubModel.fromEntity(UserPub user) {
    return UserPubModel(
      docId: user.docId,
      country: user.country,
      fullName: user.fullName,
      about: user.about, 
      gender: user.gender,
      birthdate: user.birthdate,
      imageUrl: user.imageUrl,
    );
  }

  factory UserPubModel.fromPrivateEntity(UserPrv user) {
    return UserPubModel(
      docId: user.docId,
      country: user.country,
      fullName: user.fullName,
      about: user.about, 
      gender: user.gender,
      birthdate: user.birthdate,
      imageUrl: user.imageUrl,
    );
  }


   UserPubModel copyWith({
    String? docId,
    String? country,
    String? fullName,
    String? imageUrl,
    String? about,
    Gender? gender,
    DateTime? birthdate,
  }) {
    return UserPubModel(
      docId: docId ?? this.docId,
      country: country ?? this.country,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      birthdate: birthdate ?? this.birthdate,
      imageUrl: imageUrl ?? this.imageUrl,
      about: about ?? this.about,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'country': country,
      'fullName': fullName,
      'imageUrl': imageUrl,
      'about': about,
      'gender':gender?.name, 
      "birthdate": birthdate
    };
  }

  factory UserPubModel.fromMap(Map<String, dynamic> map) {
    return UserPubModel(
      docId: map['docId'] ?? map['id'] ?? '',
      country: map['country'] ?? '',
      fullName: map['fullName'] ?? '',
      gender: map['gender'] == null ? null
              : map['gender'] == Gender.male.name ? Gender.male
              : map['gender'] == Gender.female.name ? Gender.female
              : map['gender'] == Gender.other.name ? Gender.other
              : null,
      birthdate: map['birthdate'].runtimeType == Timestamp ? (map['birthdate'] as Timestamp).toDate() : DateTime.parse(map['birthdate']),
      imageUrl: map["imageUrl"] ?? '',
      about: map["about"] ?? '',
    );
  }

  @override
  bool operator ==(covariant UserPubModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docId == docId &&
      other.country == country &&
      other.fullName == fullName &&
      other.imageUrl == imageUrl &&
      other.gender == gender &&
      other.birthdate == birthdate &&
      other.about == about;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
      country.hashCode ^
      fullName.hashCode ^
      imageUrl.hashCode ^
      gender.hashCode ^
      birthdate.hashCode ^
      about.hashCode;
  }

}