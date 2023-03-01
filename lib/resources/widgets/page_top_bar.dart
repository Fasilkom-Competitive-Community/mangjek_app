import 'package:flutter/material.dart';

class PageTopBar extends StatelessWidget {
  final bool withBackIcon;
  final String pageName;
  PageTopBar({super.key, required this.withBackIcon, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          if (withBackIcon)
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
              ),
            ),
          Text(
            pageName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
