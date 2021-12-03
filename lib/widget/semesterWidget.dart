import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:siatma_mobile/api/khs_api.dart';
import 'package:siatma_mobile/api/presensi_api.dart';

import 'package:siatma_mobile/api/semester_api.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/item/semester.dart';
import 'package:siatma_mobile/model/kartuhasilstudi_model.dart';

import 'package:siatma_mobile/model/semester_model.dart';

class Semesterview extends StatefulWidget {
  @override
  _SemesterviewState createState() => _SemesterviewState();
}

class _SemesterviewState extends State<Semesterview> {
  @override
  void initState() {
    // final prefs = await SharedPreferences.getInstance();
    if (Provider.of<AkademikSemester>(context, listen: false).items != [])
      Provider.of<AkademikSemester>(context, listen: false).fetchSemester();
    init();
    super.initState();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();

    String init = prefs.getString('tattp') ?? '0';
    prefs.setString('ta', init);
    Provider.of<IPSP>(context, listen: false).fetchIps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: blueatmacolor, body: SemesterList());
  }
}

class SemesterList extends StatefulWidget {
  @override
  _SemesterListState createState() => _SemesterListState();
}

class _SemesterListState extends State<SemesterList> {
  int _current = 0;
  @override
  @override
  Widget build(BuildContext context) {
    final semesterLists = Provider.of<AkademikSemester>(context);
    final semester = semesterLists.items ?? [];

    // List<Semester> temp = [Semester(semesterakademik: "")];
    return Container(
      color: blueatmacolor,
      child: CarouselSlider.builder(
        options: CarouselOptions(
            reverse: true,
            height: 150,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            viewportFraction: 0.55,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
                savePref(semester[index].semesterakademik, context, semester);
                // Provider.of<KartuHS>(context, listen: false).fetchKHS();
              });
            }),
        itemCount: semester.length > 0 ? semester.length : 6,
        itemBuilder: semester.length > 0
            ? (context, index, realindex) => SemesterItem(
                semester[index], semester.length - index, _current, index)
            : (context, index, realindex) => ShimmerSemesterItem(),
      ),
    );
  }

  savePref(String value, BuildContext context, List<Semester> list) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('ta', value);
    prefs.setString('tattp', list[0].semesterakademik);
    // String taganti = prefs.getString('ta') ?? '0';
    Provider.of<PresensiP>(context, listen: false).initpresensi();
    Provider.of<IPSP>(context, listen: false).initipsks();
    Provider.of<KartuHS>(context, listen: false).initkhs();
    Provider.of<KartuHS>(context, listen: false).fetchKHS();
    Provider.of<IPSP>(context, listen: false).fetchIps();
    Provider.of<PresensiP>(context, listen: false).fetchPresensi();

    // print(taganti);
    // // print(tatetap + " tetap");
  }

  saveindex(String value) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('index', value);
  }
}
