import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:mangjek_app/app/firebase/firebase.dart';
import 'package:mangjek_app/app/models/user.dart';
import 'package:mangjek_app/app/networking/profile_service.dart';
import 'package:mangjek_app/app/utils/widget.dart';
import 'package:mangjek_app/bootstrap/helpers.dart';

import 'controller.dart';

class ProfileController extends Controller {
  @override
  construct(BuildContext context) {
    super.construct(context);
  }

  static String get registerNameKey => "name";
  static String get registerEmailKey => "email";
  static String get registerPhoneNumberKey => "phone_number";
  static String get registerNimKey => "nim";
  static String get registerFakultasKey => "nim";
  static String get registerJurusanKey => "nim";
  static String get registerAlamatKey => "nim";
  static String get registerAngkatanKey => "nim";

  Map<String, String> _registerData = {};
  void setRegisterData(String key, String value) {
    _registerData[key] = value;
  }

  RegExp regexPhoneNumber = RegExp("^(?:\\+628|628|08)([0-9]{9,11})\$");

  bool validateRegisterForm(BuildContext context) {
    String name = _registerData[registerNameKey] ?? "";
    if (name.length <= 0) {
      popUpValidationError(this.context!, "Heyy",
          "Harap masukkan nama kamu terlebih dahulu", 14, 110);
      return false;
    }

    String phoneNumber = _registerData[registerPhoneNumberKey] ?? "";
    if (phoneNumber.length <= 0) {
      popUpValidationError(this.context!, "Heyy",
          "Harap masukkan nomor handphone kamu terlebih dahulu", 14, 110);
      return false;
    }

    var matchPhone = regexPhoneNumber
        .firstMatch(_registerData[registerPhoneNumberKey] ?? "");
    if (matchPhone == null || matchPhone[0] == null) {
      popUpValidationError(context, "Heyy",
          "Sepertinya nomor handphone yang kamu masukkan tidak valid", 14, 110);
      return false;
    }

    var phoneNumFinal = "+62" + matchPhone[0]!;
    // var phoneNumFinal = matchPhone[0]!;
    setRegisterData(registerPhoneNumberKey, phoneNumFinal);
    return true;
  }

  Future<UserResponse?> registerProfile() async {
    String uid = AuthInstance.currentUser?.uid ?? "";
    String token = await AuthInstance.currentUser?.getIdToken() ?? "";
    String email = AuthInstance.currentUser?.email ?? "";
    String phoneNumber = _registerData[registerPhoneNumberKey] ?? "";
    String name = _registerData[registerNameKey] ?? "";
    String fcmToken = await FcmInstance.getToken() ?? "";

    var resp = await api<ProfileService>((request) => request.registerProfile(
        uid, name, email, phoneNumber, token, fcmToken));

    return resp;
  }
}
