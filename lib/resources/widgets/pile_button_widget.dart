import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nylo_framework/nylo_framework.dart';

class PileButtonWidget extends StatelessWidget {
  final String iconLocation;
  final String label;
  final void Function() onTap;
  const PileButtonWidget({
    super.key,
    required this.iconLocation,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      splashColor: Colors.red,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.black,
          ),
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            Image.asset(
              getImageAsset(this.iconLocation),
              width: 30,
              height: 30,
            ),
            Text(this.label),
          ],
        ),
      ),
    );
  }
}
