import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mangjek_app/app/bloc/home/profile/profile_cubit.dart';
import 'package:mangjek_app/app/controllers/profile_controller.dart';
import 'package:mangjek_app/app/extensions/string.dart';
import 'package:mangjek_app/app/firebase/firebase.dart';
import 'package:mangjek_app/app/models/user.dart' as user_model;
import 'package:mangjek_app/app/singleton/media_query.dart';
import 'package:mangjek_app/app/utils/debouncer.dart';
import 'package:mangjek_app/routes/constant.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProfileUserPage extends NyStatefulWidget {
  ProfileUserPage({super.key});

  final ProfileController controller = ProfileController();

  @override
  State<ProfileUserPage> createState() => _ProfileUserState();
}

class _ProfileUserState extends NyState<ProfileUserPage> {
  File? image;
  final ImagePicker _picker = ImagePicker();
  final User? user = FirebaseAuth.instance.currentUser;

  late ProfileCubit _profileCubit = context.read<ProfileCubit>();

  user_model.User? currentLoggedInUser;
  bool fromOnboarding = false;

  @override
  init() async {
    super.init();

    Map? data = widget.data() as Map?;
    if (data != null && data["from_onboarding"]) {
      fromOnboarding = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getImage() async {
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.gallery);
    image = File(imagePicked!.path);
    setState(() {});
  }

  Future takePhoto() async {
    final XFile? photoTaken =
        await _picker.pickImage(source: ImageSource.camera);
    image = File(photoTaken!.path);
    setState(() {});
  }

  Widget changePhoto() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.0),
                ),
              ),
              builder: ((builder) => bottomSheet()));
        },
        child: Stack(
          children: [
            image != null
                ? CircleAvatar(
                    radius: 35,
                    child: ClipOval(
                        child: new SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                      ),
                    )),
                  )
                : CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(
                      getImageAsset('image-profile.png'),
                    ),
                  ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  child: ImageIcon(
                    AssetImage(
                      getImageAsset('edit.png'),
                    ),
                    color: 'F3C703'.toColor(),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 120.0,
      // width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: [
          Text(
            'Pilih Foto Profil',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(
                  Icons.camera_alt,
                  size: 40,
                ),
                style: TextButton.styleFrom(
                  foregroundColor: 'ABADAC'.toColor(),
                ),
                label: Text('Kamera'),
                onPressed: () async {
                  takePhoto();
                },
              ),
              SizedBox(
                width: 20,
              ),
              TextButton.icon(
                icon: Icon(Icons.image, size: 37),
                style: TextButton.styleFrom(
                  foregroundColor: 'ABADAC'.toColor(),
                ),
                label: Text('Galeri'),
                onPressed: () async {
                  getImage();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget __createFormEdit(
      String label, String value, String labelIcon, String keyData,
      {onlyNumber = false}) {
    Debouncer debouncer = Debouncer(milliseconds: 200);
    return Container(
        margin: EdgeInsets.only(top: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: '4B4B4B'.toColor(), fontSize: 12),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                initialValue: value,
                keyboardType:
                    onlyNumber ? TextInputType.number : TextInputType.text,
                style: TextStyle(
                  fontSize: 14,
                ),
                onChanged: (value) {
                  debouncer.run(() {
                    widget.controller.setRegisterData(keyData, value);
                  });
                },
                enabled: keyData == ProfileController.registerPhoneNumberKey &&
                        !fromOnboarding
                    ? false
                    : true,
                decoration: InputDecoration(
                  enabled: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  filled: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: labelIcon.contains(RegExp(".svg"))
                        ? SvgPicture.asset(
                            labelIcon,
                            color: 'F3C703'.toColor(),
                          )
                        : Image.asset(
                            getImageAsset(labelIcon),
                            color: 'F3C703'.toColor(),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget formEdit() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded || state is ProfileNotFound) {
            return Container(
              padding: const EdgeInsets.only(
                bottom: 30,
              ),
              child: Column(children: [
                __createFormEdit(
                  'Nama Lengkap',
                  state.user.name,
                  'profile-circle.png',
                  ProfileController.registerNameKey,
                ),
                __createFormEdit(
                  'NIM',
                  state.user.nim,
                  'nim-icon.png',
                  ProfileController.registerNimKey,
                  onlyNumber: true,
                ),
                __createFormEdit(
                  'Nomor Handphone',
                  state.user.phoneNumber,
                  'sms-search.png',
                  ProfileController.registerPhoneNumberKey,
                  onlyNumber: true,
                ),
                __createFormEdit(
                  'Fakultas',
                  // state.user.fakultas,
                  'Fasilkom',
                  'jurusan-icon.png',
                  ProfileController.registerFakultasKey,
                ),
                __createFormEdit(
                  'Jurusan',
                  // state.user.jurusan,
                  'Teknik Informatika',
                  'jurusan-icon.png',
                  ProfileController.registerJurusanKey,
                ),
                __createFormEdit(
                  'Angkatan',
                  // state.user.angkatan,
                  '2020',
                  'angkatan-icon.png',
                  ProfileController.registerAngkatanKey,
                ),
                __createFormEdit(
                  'Alamat Tempat Tinggal',
                  // state.user.alamat,
                  'Indralaya',
                  'alamat-icon.png',
                  ProfileController.registerAlamatKey,
                ),
                SizedBox(
                  height: 40,
                ),
                __createButtonSubmit(context),
                if (fromOnboarding)
                  Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        context
                            .read<ProfileCubit>()
                            .resetProfileStateToInitialState();
                        await AuthInstance.signOut();
                        routeTo(ROUTE_INITIAL_PAGE,
                            navigationType: NavigationType.pushAndForgetAll);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red.shade400,
                        ),
                      ),
                      child: Text("Logout"),
                    ),
                  )
              ]),
            );
          }

          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> submitForm() async {
    EasyLoading.show(status: 'loading...');
    var resp = await widget.controller.registerProfile();
    Timer(Duration(seconds: 2), () {
      EasyLoading.dismiss();
      if (resp != null) {
        _profileCubit.resetProfileStateToInitialState();
        routeTo(ROUTE_HOME_PAGE);
      }
    });
  }

  Widget __createButtonSubmit(BuildContext context) {
    return Container(
      width: MediaQuerySingleton.screenSize.width * 0.5,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          if (widget.controller.validateRegisterForm(context)) {
            submitForm();
          }
        },
        child: Text("Submit"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Profilku',
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        titleSpacing: -10,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                changePhoto(),
                formEdit(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
