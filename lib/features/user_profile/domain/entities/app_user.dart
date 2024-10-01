class AppUser {
  final String id;
  String email;
  String country;
  String contactNo;
  String fullName;
  final DateTime joinedAt;
  final String imageId;
  String profession;

  AppUser({
    required this.id,
    required this.email,
    required this.country,
    required this.contactNo,
    required this.fullName,
    required this.joinedAt,
    required this.imageId,
    required this.profession,
  });
}