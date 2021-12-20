import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.only(bottom: 10, right: 5, left: 5),
          child: AutoSizeText(
            "©2021 Kantor Sistem Infomrasi Universitas Atma Jaya Yogyakarta",
            textAlign: TextAlign.center,
            maxLines: 1,
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
