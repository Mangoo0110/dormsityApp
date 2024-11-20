


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/enums/common_enums.dart';
import '../../domain/entities/user_prv.dart';

class UserPrvModel extends UserPrv {
  UserPrvModel({
    required super.docId,
    required super.email,
    required super.fullName,
    required super.gender,
    required super.birthdate,
    required super.joinedAt,
    required super.imageUrl,
    required super.about, 
    required super.country, 
    required super.contactNo,
  });

  factory UserPrvModel.fromEntity(UserPrv user) {
    return UserPrvModel(
      docId: user.docId,
      email:user.email,
      country: user.country,
      contactNo: user.contactNo,
      fullName: user.fullName,
      gender: user.gender,
      birthdate: user.birthdate,
      joinedAt: user.joinedAt,
      imageUrl: user.imageUrl,
      about: user.about,
    );
  }


   UserPrvModel copyWith({
    String? docId,
    String? email,
    String? country,
    String? contactNo,
    Gender? gender,
    DateTime? birthdate,
    String? fullName,
    DateTime? joinedAt,
    String? imageUrl,
    String? about,
  }) {
    return UserPrvModel(
      docId: docId ?? this.docId,
      email: email ?? this.email,
      country: country ?? this.country,
      contactNo: contactNo ?? this.contactNo,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      birthdate: birthdate ?? this.birthdate,
      joinedAt: joinedAt ?? this.joinedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      about: about ?? this.about,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'email': email,
      'country': country,
      'contactNo': contactNo,
      'fullName': fullName,
      'gender': gender?.name,
      'birthdate': birthdate,
      'joinedAt': joinedAt,
      'imageUrl': imageUrl,
      'about': about,
    };
  }

  factory UserPrvModel.fromMap(Map<String, dynamic> map) {
    return UserPrvModel(
      docId: map['docId'] ?? map['id'] ?? '',
      email: map['email'] ?? '',
      country: map['country'] ?? '',
      contactNo: map['contactNo'] ?? '',
      fullName: map['fullName'] ?? '',
      gender: map['gender'] == null ? null
              : map['gender'] == Gender.male.name ? Gender.male
              : map['gender'] == Gender.female.name ? Gender.female
              : map['gender'] == Gender.other.name ? Gender.other
              : null,
      birthdate: map['birthdate'] == null ? null : map['birthdate'].runtimeType == Timestamp ? (map['birthdate'] as Timestamp).toDate() : DateTime.parse(map['birthdate']),
      imageUrl: map["imageUrl"] ?? '',
      joinedAt:  map['joinedAt'] == null ? null : map['joinedAt'].runtimeType == Timestamp ? (map['joinedAt'] as Timestamp).toDate() : DateTime.parse(map['joinedAt']), 
      about: map["about"] ?? '',
    );
  }

  @override
  String toString() {
    return 'UserPrvModel(docId: $docId, email: $email, country: $country, contactNo: $contactNo, fullName: $fullName, gender: $gender, birthdate: ${birthdate == null ? 'null' : DateFormat.yMMMd().format(birthdate!)}, imageUrl: $imageUrl, about: $about)';
  }

  @override
  bool operator ==(covariant UserPrvModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docId == docId &&
      other.email == email &&
      other.country == country &&
      other.contactNo == contactNo &&
      other.fullName == fullName &&
      other.gender == gender &&
      other.birthdate == birthdate &&
      //other.joinedAt == joinedAt &&
      other.imageUrl == imageUrl &&
      other.about == about;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
      email.hashCode ^
      country.hashCode ^
      contactNo.hashCode ^
      fullName.hashCode ^
      gender.hashCode ^
      birthdate.hashCode ^
      //joinedAt.hashCode ^
      imageUrl.hashCode ^
      about.hashCode;
  }

}