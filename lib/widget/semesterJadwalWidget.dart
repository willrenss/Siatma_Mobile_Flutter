import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siatma_mobile/api/jadwal_api.dart';
import 'package:siatma_mobile/api/semester_api.dart';
import 'package:siatma_mobile/components/Colors.dart';
import 'package:siatma_mobile/item/semester.dart';
import 'package:siatma_mobile/model/semester_model.dart';

class SemesterJadwalview extends StatefulWidget {
  @override
  _SemesterviewState createState() => _SemesterviewState();
}

class _SemesterviewState extends State<SemesterJadwalview> {
  @override
  void initState() {
    // final prefs = await SharedPreferences.getInstance();
    if (Provider.of<SemesterJadwal>(context, listen: false).items != [])
      Provider.of<SemesterJadwal>(context, listen: false).fetchSemesterJadwal();

    init();
    super.initState();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();

    String init = prefs.getString('tattp') ?? '0';
    prefs.setString('taj', init);
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
  Widget build(BuildContext context) {
    final semesterLists = Provider.of<SemesterJadwal>(context);
    final semester = semesterLists.items ?? [];

    List<Semester> temp = [Semester(semesterakademik: "")];
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
              });
            }),
        itemCount: semester.length > 0 ? semester.length : temp.length,
        itemBuilder: semester.length > 0
            ? (context, index, realindex) => SemesterItem(
                semester[index], semester.length - index, _current, index)
            : (context, index, realindex) => ShimmerSemesterItem(),
      ),
    );
  }

  saveindex(String value) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('index', value);
  }

  savePref(String value, BuildContext context, List<Semester> list) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('taj', value);
    prefs.setString('tattp', list[0].semesterakademik);

    Provider.of<JadwalKP>(context, listen: false).initjadwal();
    Provider.of<JadwalUP>(context, listen: false).initjadwal();
    Provider.of<JadwalKP>(context, listen: false).fetchJadwalK();
    Provider.of<JadwalUP>(context, listen: false).fetchJadwalU();
  }
}
