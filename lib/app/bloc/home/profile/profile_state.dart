part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  late final user_model.User user;

  ProfileState({user_model.User? user}) {
    if (user == null) {
      this.user = user_model.User();
    } else {
      this.user = user;
    }
  }

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadError extends ProfileState {
  final DioError error;
  ProfileLoadError(this.error);
}

class ProfileNotFound extends ProfileState {
  final DioError error;
  ProfileNotFound(this.error);
}

class ProfileFirebaseNotLoggedIn extends ProfileState {
  ProfileFirebaseNotLoggedIn();
}

class ProfileLoaded extends ProfileState {
  ProfileLoaded(user_model.User user) : super(user: user);

  @override
  List<Object> get props => [user.id];
}
