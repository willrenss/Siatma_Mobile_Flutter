import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:siatma_mobile/model/beritamodel.dart';
import 'package:siatma_mobile/view/beritaScreen.dart';

class BeritaItem extends StatelessWidget {
  final Berita beritadata;

  BeritaItem(this.beritadata);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Hero(
          tag: beritadata.idberita,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: Image.memory(
                    base64.decode(beritadata.gambar),
                  ).image,
                  fit: BoxFit.cover),
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: AutoSizeText(
                      beritadata.judul,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          )),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BeritaScreen(beritadata.idberita)),
        );
      },
    );
  }
}
