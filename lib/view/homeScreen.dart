import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siatma_mobile/api/api_service.dart';
import 'package:siatma_mobile/api/formevaluasi_api.dart';
import 'package:siatma_mobile/api/jadwal_api.dart';
import 'package:siatma_mobile/api/mahasiswa_api.dart';
import 'package:intl/intl.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/model/formevaluasi_model.dart';
import 'package:siatma_mobile/model/mahasiswa_model.dart';
import 'package:siatma_mobile/view/formEvaluasiScreen.dart';
import 'package:siatma_mobile/view/pembayaranScreen.dart';
import 'package:siatma_mobile/view/presensiScreen.dart';
import 'package:siatma_mobile/widget/beritawidget.dart';
import 'package:siatma_mobile/widget/jadwalhariiniWidget.dart';
import 'nilaiScreen.dart';

class HomeScreen extends StatefulWidget {
  final bool cek;
  HomeScreen(this.cek);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  APIService apiService = new APIService();
  CarouselController buttonCarouselController = CarouselController();
  Mahasiswa mahasiswa = new Mahasiswa();
  FormE form = new FormE();
  String day = DateFormat("dd-MMM-yyyy").format(DateTime.now());
  bool cekloading;
  DateTime now = DateTime.now().toLocal();
  @override
  void initState() {
    super.initState();
    cekloading = Provider.of<JadwalHariIni>(context, listen: false).cekkondisi;

    print(mahasiswa);
    print(form);
    if (widget.cek == false) {
      apiService.semesterShared().then((value) {
        setState(() {
          saveta(value);
        });
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (cekloading == true) {
      Provider.of<JadwalHariIni>(context, listen: false)
          .fetchJadwalK()
          .then((value) {
        Provider.of<JadwalHariIni>(context, listen: false).fetchcek(false);
        setState(() {
          cekloading = false;
        });
      });
    }
    mahasiswa = Provider.of<MahasiswaP>(context, listen: true).items;
    form = Provider.of<FormEP>(context, listen: true).items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBgColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentDirectional.topCenter,
                children: [
                  _backBgCover(),
                  _greetings(mahasiswa, greeting()),
                  _moodsHolder()
                ],
              ),
              SizedBox(
                height: 60,
              ),
              _textmenu(dayname(), day, cekloading),
              _menu(form, now),
            ],
          ),
        ),
      ),
    );
  }

  Container _menu(final form, DateTime now) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        children: [
          Card(
            color: blueatmacolor,
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: InkWell(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: AssetImage('assets/images/nilaiback.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Image.asset(
                              "assets/images/nilai.png",
                              width: 75,
                            )),
                        SizedBox(height: 15),
                        Text(
                          'Nilai',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () {
                if (now.isAfter(DateFormat("yyyy-MM-ddThh:mm:ssZ")
                        .parse(form.tglmulai)) &&
                    now.isBefore(DateFormat("yyyy-MM-ddThh:mm:ssZ")
                        .parse(form.tglselesai))) {
                  if (Provider.of<MatakuliahEP>(context, listen: false)
                      .statuscek()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NilaiScreen()),
                    );
                  } else {
                    final snackBar = SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red[800],
                      duration: Duration(milliseconds: 800),
                      content: Text(
                          "Selesaikan Form Evaluasi Dosen Terlebih Dahulu"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NilaiScreen()),
                  );
                }
              },
            ),
          ),
          Card(
            color: blueatmacolor,
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: InkWell(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: AssetImage('assets/images/presensiback.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/presensi.png",
                          width: 80,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Presensi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PresensiScreen()),
                );
              },
            ),
          ),
          Card(
            color: blueatmacolor,
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: InkWell(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: AssetImage('assets/images/evaluasiback.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/evaluasi.png",
                          width: 80,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Evaluasi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () {
                var tglselesai = DateFormat("dd-MMM-yyyy")
                    .format(DateTime.parse(form.tglselesai));
                var tglmulai = DateFormat("dd-MMM-yyyy")
                    .format(DateTime.parse(form.tglmulai));

                if (now.isAfter(DateFormat("yyyy-MM-ddThh:mm:ssZ")
                        .parse(form.tglmulai)) &&
                    now.isBefore(DateFormat("yyyy-MM-ddThh:mm:ssZ")
                        .parse(form.tglselesai))) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormEvaluasiScreen()),
                );
                } else {
                  final snackBar = SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red[800],
                    duration: Duration(milliseconds: 800),
                    content: Text(form.namaform +
                        " Dosen Mulai " +
                        tglmulai.toString() +
                        ", Akan Berakhir " +
                        tglselesai.toString()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ),
          Card(
            color: blueatmacolor,
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: InkWell(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: AssetImage('assets/images/billback.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/bill.png",
                          width: 85,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Pembayaran',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PembayaranScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _textmenu(String day, String tanggal, bool cek) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
                gradient: blueGradient2,
                borderRadius: new BorderRadius.all(Radius.circular(20))),
            padding: EdgeInsets.only(right: 60, left: 60, top: 5, bottom: 5),
            child: Text(
              "$day, $tanggal",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: JadwalHariView(cek),
          )
        ],
      ),
    );
  }

  Positioned _moodsHolder() {
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
            child: BeritaView()));
  }

  Container _backBgCover() {
    return Container(
      height: 260.0,
      decoration: BoxDecoration(
        gradient: blueGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
    );
  }

  Positioned _greetings(final mahasiswa, String now) {
    return Positioned(
      left: 20,
      width: MediaQuery.of(context).size.width - 30,
      bottom: 120,
      child: ChangeNotifierProvider(
        create: (ctx) => MahasiswaP(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mahasiswa.panggilan != null ? 'Good $now!' : "Good Day",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'How are you feeling today?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: fotobirucolor,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
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
                                      BorderRadius.all(Radius.circular(48.0)),
                                ),
                              )
                            : Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: fotobirucolor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(48.0)),
                                ),
                              )),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour <= 12) {
      return 'Morning';
    } else if ((hour > 12) && (hour <= 16)) {
      return 'Afternoon';
    } else if ((hour > 16) && (hour < 20)) {
      return 'Evening';
    } else {
      return 'Night';
    }
  }

  String dayname() {
    var day = DateFormat("EEEE").format(DateTime.now());
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

  savePref(String idProdi, String masuk) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('prodi', idProdi);
    prefs.setString('masuk', masuk);
  }

  saveta(
    String ta,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('tattp', ta);
    prefs.setString('ta', ta);
    prefs.setString('taj', ta);
  }

  clear() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.clear();
  }
}
