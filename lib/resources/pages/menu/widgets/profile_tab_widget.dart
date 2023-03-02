import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends NyState<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  getImageAsset('image-profile.png'),
                ),
                maxRadius: 25,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gandi Subara',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Fasilkom",
                    style: TextStyle(color: Colors.black, fontSize: 10.0),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Container(
                child: Image.asset(
                  getImageAsset('edit.png'),
                ),
                margin: EdgeInsets.fromLTRB(0, 10.5, 0, 10.5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
