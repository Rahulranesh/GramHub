import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/profile/profile_repo.dart';
import 'package:socialmedia/profile/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  //fetch user profile from repo
  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(ProfileLoading());
      final user = await profileRepo.fetchUserProfile(uid);

      // ignore: unnecessary_null_comparison
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError('User not found !'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  //update bio and profile picture
  Future<void> updateProfile({
    required String uid,
    String? newBio,
  }) async {
    emit(ProfileLoading());
    try {
      final currentUser = await profileRepo.fetchUserProfile(uid);
      // ignore: unnecessary_null_comparison
      if (currentUser == null) {
        emit(ProfileError('Failed to fetch user for profile update'));
      }
      //profile pic update

      //updated new profile
      final updatedProfile =
          currentUser.copyWith(newBio: newBio ?? currentUser.bio);
      //update in repo
      await profileRepo.updateProfile(updatedProfile);

      //re-fetch updated profile
      await fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError('Error updating the profile'));
    }
  }
}
