import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mangjek_app/app/extensions/string.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUserPage extends StatefulWidget {
  const ProfileUserPage({super.key});

  @override
  State<ProfileUserPage> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUserPage> {
  File? image;
  final ImagePicker _picker = ImagePicker();

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
                    backgroundImage: AssetImage('assets/img/image-profile.png'),
                  ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  child: ImageIcon(
                    AssetImage('assets/img/edit.png'),
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

  Widget __createFormEdit(String label, String labelIcon,
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
              child: TextField(
                keyboardType:
                    onlyNumber ? TextInputType.number : TextInputType.text,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  filled: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Image.asset(
                      'assets/img/' + labelIcon,
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
      child: Column(children: [
        __createFormEdit('Nama Lengkap', 'profile-circle.png'),
        __createFormEdit('NIM', 'nim-icon.png', onlyNumber: true),
        __createFormEdit('Fakultas', 'jurusan-icon.png'),
        __createFormEdit('Jurusan', 'jurusan-icon.png'),
        __createFormEdit('Angkatan', 'angkatan-icon.png'),
        __createFormEdit('Alamat Tempat Tinggal', 'alamat-icon.png'),
      ]),
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
