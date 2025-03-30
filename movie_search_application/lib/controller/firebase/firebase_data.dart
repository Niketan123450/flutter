import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_search_application/controller/session_data.dart';

class FirebaseData {
  /// creating object of Firebase to access collection data
  static FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;

  static Future<String> registerUser(Map<String, dynamic> userData) async {
    try {
      /// Firebase Authentication register user with email and password

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userData["email"],
        password: userData["password"],
      );

      /// Store users data in firestore database
      await firebaseInstance
          .collection("Users")
          .doc(userData["email"])
          .set(userData);

      return "true";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<String> loginUser(Map userData) async {
    try {
      /// Login user with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userData["email"],
        password: userData["password"],
      );

      /// fetching users data from firebase collection
      QuerySnapshot response = await firebaseInstance.collection("Users").get();

      /// To get users detials such as email and username
      for (var data in response.docs) {
        if (data["email"] == userData["email"]) {
          /// Store users data in sessiondata
          await SessionData.storeSessiondata(
            isLogin: true,
            email: data["email"],
            username: data["username"],
          );
          break;
        }
      }

      return "true";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (error) {
      return error.toString();
    }
  }

  ///Logout from both firebase and session data
  static Future<void> logoutFromFirebase() async {
    await FirebaseAuth.instance.signOut();
    await SessionData.storeSessiondata(isLogin: false, email: "", username: "");
  }
}
