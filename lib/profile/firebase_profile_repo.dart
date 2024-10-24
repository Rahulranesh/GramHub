import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/profile/profile_repo.dart';
import 'package:socialmedia/profile/profile_user.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<ProfileUser> fetchUserProfile(String uid) async {
    try {
      // Get user document from Firestore
      final userDoc =
          await firebaseFirestore.collection("users").doc(uid).get();

      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null) {
          return ProfileUser(
            bio: userData['bio'] ?? '',
            profileImageUrl: userData['profileImageUrl'].toString(),
            uid: uid,
            email: userData['email'],
            name: userData['name'],
          );
        }
      }
      // If user doesn't exist, throw an exception
      throw Exception('User not found');
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }

  @override
  Future<void> updateProfile(ProfileUser updatedProfile) async {
    try {
      // Convert profile to JSON and update Firestore
      await firebaseFirestore
          .collection("users")
          .doc(updatedProfile.uid)
          .update({
        'bio': updatedProfile.bio,
        'profileImageUrl': updatedProfile.profileImageUrl,
      });
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}
