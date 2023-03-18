import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mangjek_app/app/networking/profile_service.dart';
import 'package:mangjek_app/bootstrap/helpers.dart';
import "package:mangjek_app/app/models/user.dart" as user_model;

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  fetchCurrentProfile() async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    String token = await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";

    var userResp =
        await api<ProfileService>((req) => req.fetchProfile(uid, token));

    if (userResp != null) {
      emit(ProfileLoaded(userResp.user));
    }
  }
}
