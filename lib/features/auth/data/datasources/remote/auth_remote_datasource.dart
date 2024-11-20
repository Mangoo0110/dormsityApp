

import 'package:firebase_auth/firebase_auth.dart';

abstract interface class RemoteAuthDataSource {

  bool isSignedIn();

  Stream<UserAuth?> get currentUserAuthStream;



  Future<UserAuth> signUp({
    required String email,
    required String password,
  });

  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  /// Deletes and signs out the user.
  ///
  /// **Important**: this is a security-sensitive operation that requires the
  /// user to have recently signed in. If this requirement isn't met, ask the
  /// user to authenticate again and then call [User.reauthenticateWithCredential].
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **requires-recent-login**:
  ///  - Thrown if the user's last sign-in time does not meet the security
  ///    threshold. Use [User.reauthenticateWithCredential] to resolve. This
  ///    does not apply if the user is anonymous.
  /// 
  Future<void> deleteAccount();
}

class AuthFirebaseImpl implements RemoteAuthDataSource {

  static AuthFirebaseImpl? _instance; 
  late FirebaseAuth _authInstance;

  UserAuth? _currentUserAuth;

  AuthFirebaseImpl._(){
    _authInstance = FirebaseAuth.instance;
  }

  static AuthFirebaseImpl get instance {
    _instance ??= AuthFirebaseImpl._();
    return _instance!;
  }

  UserAuth? get currentUserAuth {

    if(_currentUserAuth != null) return _currentUserAuth;
    if(_authInstance.currentUser == null) return null;

    return UserAuth._(
      id: _authInstance.currentUser!.uid, 
      email: _authInstance.currentUser!.email ?? '', 
      emailVerified: _authInstance.currentUser!.emailVerified);

  }

  @override
  Stream<UserAuth?> get currentUserAuthStream {
    return _authInstance.authStateChanges().map((firebaseUser) {
      if(firebaseUser == null) return null;
      _currentUserAuth = UserAuth._(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        emailVerified: firebaseUser.emailVerified,
      );

      return _currentUserAuth;
    });
  }

  Stream<User?> get currentFirebaseUserAuthStream {
    return _authInstance.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  bool isSignedIn() {
    if (_authInstance.currentUser == null) {
      return false;
    }
    return true;
  }

  @override
  Future<void> signOut() async {
    try {
      await _authInstance.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserAuth> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _authInstance
          .createUserWithEmailAndPassword(email: email, password: password);
      _currentUserAuth = UserAuth._(
        id: userCredential.user!.uid,
        email: userCredential.user!.email ?? '',
        emailVerified: userCredential.user!.emailVerified,
      );
      return _currentUserAuth!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _authInstance.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount() async{
    if(_authInstance.currentUser != null){
      try {
        return await _authInstance.currentUser!.delete();
      } catch (e) {
        rethrow;
      }
    }
  }

}

class UserAuth {
  
  final String id;

  final String email;

  final bool emailVerified;

  const UserAuth._({
    required this.id,
    required this.email,
    required this.emailVerified,
  });


}