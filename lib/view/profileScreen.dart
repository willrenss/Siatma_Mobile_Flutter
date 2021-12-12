import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siatma_mobile/api/mahasiswa_api.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/components/custom_dialog.dart';
import 'package:siatma_mobile/components/keluar_dialog.dart';
import 'package:siatma_mobile/model/mahasiswa_model.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State {
  Mahasiswa mahasiswa = new Mahasiswa();
  Infomhs info = new Infomhs();
  SKSMAT sksmat = new SKSMAT();
  var myGroup = AutoSizeGroup();
  var actionGroup = AutoSizeGroup();
  var profilGroup = AutoSizeGroup();

  final DateFormat formatter = DateFormat('dd-MMM-yyyy');

  String tglLahir = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    info = Provider.of<Info>(context, listen: true).items;
    mahasiswa = Provider.of<MahasiswaP>(context, listen: true).items;
    sksmat = Provider.of<SKSMATP>(context, listen: true).items;
  }

  @override
  Widget build(BuildContext context) {
    tglLahir = mahasiswa.tglLahir == null
        ? null
        : formatter.format(DateTime.parse(mahasiswa.tglLahir));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mainBgColor,
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    _backBgCover(),
                    _textProfile(sksmat),
                    _moodsHolder(info, sksmat),
                    _greetings(mahasiswa),
                  ],
                ),
                SizedBox(height: 50),
                Center(
                  child: Center(
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [_body(mahasiswa, tglLahir), _action()],
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Container _backBgCover() {
    return Container(
      height: 270,
      decoration: BoxDecoration(
        gradient: blueGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
    );
  }

  Container _action() {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Center(
                      child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.change_circle,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    label: AutoSizeText('Ganti Password',
                        style: TextStyle(fontSize: 18),
                        maxLines: 1,
                        group: actionGroup),
                    onPressed: () {
                      showDialog<void>(
                          barrierColor: Colors.white.withOpacity(0.1),
                          context: context,
                          builder: (context) {
                            return CustomDialog();
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[800],
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                    ),
                  ))),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  flex: 1,
                  child: Center(
                      child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    label: AutoSizeText(
                      'Keluar',
                      style: TextStyle(fontSize: 18),
                      group: actionGroup,
                      maxLines: 1,
                    ),
                    onPressed: () {
                      showDialog<void>(
                          barrierColor: Colors.white.withOpacity(0.1),
                          context: context,
                          builder: (context) {
                            return KeluarDialog();
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(right: 45, left: 45),
                      primary: Colors.green[800],
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                    ),
                  ))),
            ],
          ),
        ],
      ),
    );
  }

  Container _body(final mahasiswa, String formatter) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "Nomor Induk Mahasiswa ",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          AutoSizeText(
            "${mahasiswa.npm}",
            style: TextStyle(
                fontSize: 18,
                color: blueatmacolor,
                fontWeight: FontWeight.w600),
          ),
          Divider(
            color: Colors.black45,
          ),
          AutoSizeText(
            "Nama Lengkap ",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          AutoSizeText(
            "${mahasiswa.nama}",
            style: TextStyle(
                fontSize: 18,
                color: blueatmacolor,
                fontWeight: FontWeight.w600),
          ),
          Divider(
            color: Colors.black45,
          ),
          AutoSizeText(
            "Angkatan ",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          AutoSizeText(
            "${mahasiswa.thnMasuk}",
            style: TextStyle(
                fontSize: 18,
                color: blueatmacolor,
                fontWeight: FontWeight.w600),
          ),
          Divider(
            color: Colors.black45,
          ),
          AutoSizeText(
            "Fakultas ",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          AutoSizeText(
            "${mahasiswa.fakultas}",
            style: TextStyle(
                fontSize: 18,
                color: blueatmacolor,
                fontWeight: FontWeight.w600),
          ),
          Divider(
            color: Colors.black45,
          ),
          AutoSizeText(
            "Program Studi ",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          AutoSizeText(
            "${mahasiswa.prodi}",
            style: TextStyle(
                fontSize: 18,
                color: blueatmacolor,
                fontWeight: FontWeight.w600),
          ),
          Divider(
            color: Colors.black45,
          ),
          AutoSizeText(
            "Tempat, Tanggal Lahir",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          AutoSizeText(
            "${mahasiswa.tmpLahir}, $tglLahir ",
            style: TextStyle(
                fontSize: 18,
                color: blueatmacolor,
                fontWeight: FontWeight.w600),
          ),
          Divider(
            color: Colors.black45,
          ),
          AutoSizeText(
            "Alamat di Yogyakarta",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          AutoSizeText(
            "${mahasiswa.alamat} ",
            style: TextStyle(
                fontSize: 18,
                color: blueatmacolor,
                fontWeight: FontWeight.w600),
          ),
          Divider(
            color: Colors.black45,
          ),
          AutoSizeText(
            "Agama",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          AutoSizeText(
            "${mahasiswa.agama} ",
            style: TextStyle(
                fontSize: 18,
                color: blueatmacolor,
                fontWeight: FontWeight.w600),
          ),
          Divider(
            color: Colors.black45,
          ),
          AutoSizeText(
            "Asal SMA",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          AutoSizeText(
            "${mahasiswa.sma} ",
            style: TextStyle(
                fontSize: 18,
                color: blueatmacolor,
                fontWeight: FontWeight.w600),
          ),
          Divider(
            color: Colors.black45,
          ),
          AutoSizeText(
            "Dosen Pembimbing",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          AutoSizeText(
            "${mahasiswa.namadosen} ",
            style: TextStyle(
                fontSize: 18,
                color: blueatmacolor,
                fontWeight: FontWeight.w600),
          ),
          Divider(
            color: Colors.black45,
          ),
          AutoSizeText(
            "Nama Orang Tua",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          AutoSizeText(
            "${mahasiswa.namaortu} ",
            style: TextStyle(
                fontSize: 18,
                color: blueatmacolor,
                fontWeight: FontWeight.w600),
          ),
          Divider(
            color: Colors.black45,
          ),
          AutoSizeText(
            "Alamat Orang Tua",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          AutoSizeText(
            "${mahasiswa.alamatortu} ",
            style: TextStyle(
                fontSize: 18,
                color: blueatmacolor,
                fontWeight: FontWeight.w600),
          ),
          Divider(
            color: Colors.black45,
          ),
        ],
      ),
    );
  }

  Positioned _textProfile(final info) {
    return Positioned(
        bottom: 180,
        child: Container(
          child: Text('Profile Saya',
              style: GoogleFonts.pacifico(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w200,
              )),
        ));
  }

  Positioned _moodsHolder(final info, final sksmat) {
    return Positioned(
        bottom: -70,
        child: Container(
            height: 150.0,
            width: MediaQuery.of(context).size.width - 40,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 5.5,
                    blurRadius: 5.5,
                  )
                ]),
            child: Column(children: [
              SizedBox(
                height: 45,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        AutoSizeText(
                          "SKS",
                          style: GoogleFonts.openSans(
                            color: Colors.black54,
                            fontSize: 18.5,
                            fontWeight: FontWeight.w800,
                          ),
                          group: myGroup,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            sksmat.totalsks != null
                                ? "${sksmat.totalsks}"
                                : "0",
                            style: GoogleFonts.openSans(
                              color: blueatmacolor,
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(
                      width: 40,
                      height: 80,
                      child: VerticalDivider(
                        color: blueatmacolor.withOpacity(0.4),
                        thickness: 2.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        AutoSizeText(
                          "Mata Kuliah",
                          style: GoogleFonts.openSans(
                            color: Colors.black54,
                            fontSize: 18.5,
                            fontWeight: FontWeight.w800,
                          ),
                          group: myGroup,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            sksmat.totalmatkul != null
                                ? "${sksmat.totalmatkul}"
                                : "0",
                            style: GoogleFonts.openSans(
                              color: blueatmacolor,
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(
                      width: 40,
                      height: 80,
                      child: VerticalDivider(
                        color: blueatmacolor.withOpacity(0.4),
                        thickness: 2.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        AutoSizeText(
                          "IPK",
                          style: GoogleFonts.openSans(
                            color: Colors.black54,
                            fontSize: 18.5,
                            fontWeight: FontWeight.w800,
                          ),
                          group: myGroup,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(info.ipk != null ? "${info.ipk}" : "0",
                            style: GoogleFonts.openSans(
                              color: blueatmacolor,
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            )),
                      ],
                    ),
                  ),
                ],
              )
            ])));
  }

  Positioned _greetings(final mahasiswa) {
    return Positioned(
      left: 20,
      width: MediaQuery.of(context).size.width - 30,
      bottom: 50,
      child: ChangeNotifierProvider(
        create: (ctx) => MahasiswaP(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Container(
                  width: 125.0,
                  height: 125.0,
                  decoration: BoxDecoration(
                    color: fotobirucolor,
                    borderRadius: BorderRadius.all(Radius.circular(75.0)),
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  child: mahasiswa.foto != null
                      ? Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: fotobirucolor,
                            image: DecorationImage(
                                image: Image.memory(
                                  base64.decode(mahasiswa.foto),
                                ).image,
                                fit: BoxFit.fitWidth),
                            borderRadius:
                                BorderRadius.all(Radius.circular(487.0)),
                          ),
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  clear() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.clear();
  }
}
