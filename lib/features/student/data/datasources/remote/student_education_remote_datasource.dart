import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormsity/features/student/data/models/education_model.dart';
import 'package:dormsity/features/student/data/models/student_model.dart';
import '../../../../../core/utils/constants/data_field_key_names.dart';



abstract interface class StudentEducationRemoteDataSource {
  Future<void> saveStudent({required StudentModel student});

  Future<void> approveStudent({required StudentModel student});

  Future<void> approveGraduationComplete({required StudentModel student});

  /// Only admins of institution can do a successful fetch of student list.
  Future<List<StudentModel>> fetchStudents({required String institutionDomain}); 

  Future<List<EducationModel>> fetchUserEducationList({required String userId});
  
}

class StudentEducationFirebaseImpl implements StudentEducationRemoteDataSource{

  CollectionReference<Map<String,dynamic>> _educationCollection(){
    return FirebaseFirestore.instance.collection(kFirestoreEducationCollection);
  }

  CollectionReference<Map<String,dynamic>> _studentCollection(){
    return FirebaseFirestore.instance.collection(kFirestoreStudentCollection);
  }

  @override
  Future<List<EducationModel>> fetchUserEducationList({required String userId}) async{
    
    return await _educationCollection().where(kuserId, isEqualTo: userId).get().then((qSnapMap){
      return qSnapMap.docs.map((qDocSnap) => EducationModel.fromJson(json: qDocSnap.data())).toList();
    });

  }
  
  @override
  Future<void> approveGraduationComplete({required StudentModel student}) async{
    return await _studentCollection().doc(student.id).update({kgraduationApproved: true});
  }
  
  @override
  Future<void> approveStudent({required StudentModel student}) async{
    return await _studentCollection().doc(student.id).update({kinstitutionApproved: true});
  }
  
  @override
  Future<List<StudentModel>> fetchStudents({required String institutionDomain}) async{
    return await _studentCollection().where(kinstitutionDomain, isEqualTo: institutionDomain).get().then((qSnapMap){
      return qSnapMap.docs.map((qDocSnap) => StudentModel.fromJson(json: qDocSnap.data())).toList();
    });
  }
  
  @override
  Future<void> saveStudent({required StudentModel student}) async{
    return await _studentCollection().doc(student.id).set(student.toJson());
  }

}