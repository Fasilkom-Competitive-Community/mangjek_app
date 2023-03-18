part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final user_model.User user;

  ProfileLoaded(this.user);

  @override
  List<Object> get props => [user.id];
}
