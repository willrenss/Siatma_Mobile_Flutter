import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:siatma_mobile/api/mahasiswa_api.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class BeritaScreen extends StatelessWidget {
  final int idberita;
  BeritaScreen(this.idberita);

  @override
  Widget build(BuildContext context) {
    final loadedBerita =
        Provider.of<BeritaP>(context, listen: false).findById(idberita);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: blueatmacolor,
              expandedHeight: 250,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: loadedBerita.idberita,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: Image.memory(
                            base64.decode(loadedBerita.gambar),
                          ).image,
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: AutoSizeText(
                    loadedBerita.judul,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    maxLines: 2,
                    style: GoogleFonts.getFont('Nunito',
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 30,
                            color: blueatmacolor)),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: AutoSizeText(
                    namahari(loadedBerita.tglmulai) +
                        DateFormat(", dd-MMM-yyy HH:mm ")
                            .format(DateTime.parse(loadedBerita.tglmulai))
                            .toString() +
                        "WIB",
                    textAlign: TextAlign.left,
                    softWrap: true,
                    maxLines: 2,
                    style: GoogleFonts.getFont('Lato',
                        textStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black45)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  child: Text(
                    loadedBerita.deskripsi,
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    style: GoogleFonts.getFont('Poppins',
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.black87)),
                  ),
                ),
                if (loadedBerita.link != "null")
                  SizedBox(
                    height: 30,
                  ),
                if (loadedBerita.link != "null")
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 120),
                    child: Container(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        primary: blueatmacolor,
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () => launch(loadedBerita.link),
                      child: Text(
                        'Klik Disini',
                        style: GoogleFonts.getFont('Lato',
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: Colors.white)),
                      ),
                    )),
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  String namahari(String dayout) {
    var day = DateFormat("EEEE").format(DateTime.parse(dayout));
    if (day == "Monday")
      return 'Senin';
    else if (day == "Tuesday")
      return 'Selasa';
    else if (day == "Wednesday")
      return 'Rabu';
    else if (day == "Thursday")
      return 'Kamis';
    else if (day == "Friday")
      return 'Jumat';
    else if (day == "Saturday")
      return 'Sabtu';
    else
      return 'Minggu';
  }
}
