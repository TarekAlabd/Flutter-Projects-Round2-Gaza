import 'package:chat_app/core/models/user_data.dart';
import 'package:chat_app/core/services/firestore_services.dart';
import 'package:chat_app/core/utils/api_paths.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  Future<bool> login(String email, String password);
  Future<bool> register(String email, String password);
  Future<void> logout();
  Future<bool> isLoggedIn();
  User? getUserInit();
  Future<UserData> getUserData();
}

class AuthServicesImpl implements AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;
  final firestore = FirestoreService.instance;

  @override
  Future<bool> login(String email, String password) async {
    UserCredential userData = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (userData.user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> register(String email, String password) async {
    UserCredential userData = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    if (userData.user != null) {
      UserData user = UserData(
        uid: userData.user!.uid,
        email: email,
        password: password,
      );
      await firestore.setData(
        path: ApiPaths.user(userData.user!.uid),
        data: user.toMap(),
      );
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> isLoggedIn() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  User? getUserInit() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<UserData> getUserData() async {
    try {
      final currentUser = getUserInit();
      return await firestore.getDocument(
        path: ApiPaths.user(currentUser?.uid ?? ''),
        builder: (data, documentId) => UserData.fromMap(data),
      );
    } catch (e) {
      rethrow;
    }
  }
}
