import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mangjek_app/app/firebase/firebase.dart';
import "package:mangjek_app/app/models/user.dart" as user_model;
import 'package:mangjek_app/app/networking/profile_service.dart';
import 'package:mangjek_app/bootstrap/helpers.dart';
import 'package:nylo_framework/nylo_framework.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  _fetchCurrentProfile() async {
    String uid = AuthInstance.currentUser?.uid ?? "";
    String token = await AuthInstance.currentUser?.getIdToken() ?? "";

    var userResp = await api<ProfileService>((req) => req.fetchProfile(
          uid,
          token,
          handleFailure: (error) {
            if (error.response?.statusCode == 404) {
              emit(ProfileNotFound(error));
              return;
            }

            if (error.response?.statusCode != null &&
                error.response!.statusCode! >= 500) {
              emit(ProfileLoadError(error));
              return;
            }
          },
        ));

    if (userResp != null) {
      emit(ProfileLoaded(userResp.user));
    }
  }

  fetchCurrentProfileIfNotLoaded() async {
    if (state is ProfileInitial) {
      _fetchCurrentProfile();
      return;
    }

    return;
  }

  firebaseIsNotLoggedIn() {
    emit(ProfileFirebaseNotLoggedIn());
  }

  resetProfileStateToInitialState() {
    emit(ProfileInitial());
  }
}
