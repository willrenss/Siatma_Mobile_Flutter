import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.only(bottom: 10, right: 5, left: 5),
          child: Text(
            "©2021 Kantor Sistem Infomrasi Universitas Atma Jaya Yogyakarta",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/LoginBack.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
