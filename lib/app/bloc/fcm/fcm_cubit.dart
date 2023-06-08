import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fcm_state.dart';

class FcmCubit extends Cubit<FcmState> {
  FcmCubit() : super(FcmInitial());
}
