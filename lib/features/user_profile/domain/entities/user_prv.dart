// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:intl/intl.dart';

import '../../../../core/utils/enums/common_enums.dart';

class UserPrv {
  final String docId;
  String email;
  String country;
  String contactNo;
  String fullName;
  Gender? gender;
  DateTime? birthdate;
  final DateTime? joinedAt;
  String imageUrl;
  String about;

  UserPrv({
    required this.docId,
    required this.email,
    required this.country,
    required this.contactNo,
    required this.fullName,
    required this.gender,
    required this.birthdate,
    required this.joinedAt,
    required this.imageUrl,
    required this.about,
  });

  @override
  String toString() {
    return 'UserPrv(docId: $docId, email: $email, country: $country, contactNo: $contactNo, fullName: $fullName, gender: $gender, birthdate: ${birthdate == null ? 'null' : DateFormat.yMMMd().format(birthdate!)}, imageUrl: $imageUrl, about: $about)';
  }
}
