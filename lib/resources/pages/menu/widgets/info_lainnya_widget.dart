import 'package:flutter/material.dart';
import 'package:mangjek_app/app/extensions/string.dart';
import 'package:mangjek_app/app/firebase/firebase.dart';
import 'package:mangjek_app/resources/pages/auth/login/login_widget.dart';
import 'package:mangjek_app/resources/pages/menu/constant.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/onboarding/first_onboarding_widget.dart'
    as first_onboarding_widget;

class InfoLainnya extends StatefulWidget {
  const InfoLainnya({super.key});

  @override
  State<InfoLainnya> createState() => _InfoLainnyaState();
}

class _InfoLainnyaState extends State<InfoLainnya> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultHorizontalPadding,
                ),
                child: Text(
                  'Info Lainnya',
                  style: TextStyle(
                    color: '4B4B4B'.toColor(),
                    fontSize: 12,
                  ),
                ),
              ),
              __listInfo('setting-2.png', 'Pengaturan'),
              __listInfo('direct-right.png', 'Masukan dan dukungan'),
              __listInfo(
                  'notification-bing.png', 'Pemberitahuan (update fitur)'),
              __listInfo('task-square.png', 'Daftar menjadi driver'),
              __listInfo('book-square.png', 'Tentang aplikasi'),
              __listInfo('logout.png', 'Log out', onTap: () async {
                await AuthInstance.signOut();
                if (!mounted) return;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                    (route) => false);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget __listInfo(String imgName, String nameInfo, {void Function()? onTap}) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultHorizontalPadding,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: "#EBEFED".toColor(),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 7,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 7.5, 0, 7.5),
                          child: Image.asset(
                            getImageAsset(imgName),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(11, 7.5, 0, 7.5),
                          child: Text(
                            nameInfo,
                            style: TextStyle(fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            getImageAsset('arrow-right.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
