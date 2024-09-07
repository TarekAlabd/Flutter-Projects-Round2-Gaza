import 'package:ecommerce/models/user_data.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utils/api_path.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final firebaseAuth = FirebaseAuth.instance;
  final firestoreServices = FirestoreServices.instance;

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (userCredential.user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (userCredential.user != null) {
      final user = userCredential.user;
      final userData = UserData(
        uid: user!.uid,
        email: user.email!,
        photoURL: user.photoURL,
        name: user.displayName,
      );
      await firestoreServices.setData(
        path: ApiPath.user(userData.uid),
        data: userData.toMap(),
      );
      return true;
    } else {
      return false;
    }
  }

  User? get currentUser {
    return firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
