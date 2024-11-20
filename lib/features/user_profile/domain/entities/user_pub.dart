import '../../../../core/utils/enums/common_enums.dart';

class UserPub {
  final String docId;
  String country;
  String fullName;
  Gender? gender;
  DateTime? birthdate;
  final String imageUrl;
  String about;

  UserPub({
    required this.docId,
    required this.country,
    required this.fullName,
    required this.gender,
    required this.birthdate,
    required this.imageUrl,
    required this.about,
  });
  
}