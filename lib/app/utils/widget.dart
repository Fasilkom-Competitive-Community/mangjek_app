import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mangjek_app/app/extensions/constructor.dart';

void popUpValidationError(BuildContext context, String judul, String isi,
    double font, double height) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: SvgPicture.asset(assetsIconAlert),
        content: SizedBox(
          width: double.infinity,
          height: height,
          child: Column(
            children: <Widget>[
              Text(
                judul,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                isi,
                style: TextStyle(fontSize: font),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      );
    },
  );
}
