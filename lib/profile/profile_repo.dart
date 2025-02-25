/*
Profile Repo



*/

import 'package:socialmedia/profile/profile_user.dart';

abstract class ProfileRepo {
  Future<ProfileUser> fetchUserProfile(String uid);
  Future<void> updateProfile(ProfileUser updatedProfile);
}
