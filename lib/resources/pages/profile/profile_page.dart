import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mangjek_app/app/bloc/home/profile/profile_cubit.dart';
import 'package:mangjek_app/app/controllers/controller.dart';
import 'package:mangjek_app/app/extensions/string.dart';
import 'package:mangjek_app/app/networking/profile_service.dart';
import 'package:mangjek_app/app/models/user.dart' as user_model;
import 'package:mangjek_app/bootstrap/helpers.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProfileUserPage extends NyStatefulWidget {
  ProfileUserPage({super.key});

  final Controller controller = Controller();

  @override
  State<ProfileUserPage> createState() => _ProfileUserState();
}

class _ProfileUserState extends NyState<ProfileUserPage> {
  File? image;
  final ImagePicker _picker = ImagePicker();
  final User? user = FirebaseAuth.instance.currentUser;

  user_model.User? currentLoggedInUser;
  late ProfileCubit _profileCubit;

  @override
  init() async {
    super.init();
    _profileCubit = context.read<ProfileCubit>()..fetchCurrentProfile();
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

  Widget __createFormEdit(String label, String value, String labelIcon,
      {onlyNumber = false}) {
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
                enabled: false,
                decoration: InputDecoration(
                  enabled: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  filled: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Image.asset(
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
          log("test here state : ${state}");
          if (state is ProfileLoaded) {
            return Column(children: [
              __createFormEdit(
                'Nama Lengkap',
                state.user.name,
                'profile-circle.png',
              ),
              __createFormEdit(
                'NIM',
                state.user.nim,
                'nim-icon.png',
                onlyNumber: true,
              ),
              __createFormEdit(
                  'Fakultas',
                  // state.user.fakultas,
                  'Fasilkom',
                  'jurusan-icon.png'),
              __createFormEdit(
                  'Jurusan',
                  // state.user.jurusan,
                  'Teknik Informatika',
                  'jurusan-icon.png'),
              __createFormEdit(
                  'Angkatan',
                  // state.user.angkatan,
                  '2020',
                  'angkatan-icon.png'),
              __createFormEdit(
                  'Alamat Tempat Tinggal',
                  // state.user.alamat,
                  'Indralaya',
                  'alamat-icon.png'),
            ]);
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
        ));
  }
}
