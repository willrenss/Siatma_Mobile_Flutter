import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/jadwal_api.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/item/jadwalHari.dart';
import 'package:siatma_mobile/item/semester.dart';

class JadwalHariView extends StatefulWidget {
  final bool cek;

  JadwalHariView(this.cek);
  @override
  _JadwalHariViewState createState() => _JadwalHariViewState();
}

class _JadwalHariViewState extends State<JadwalHariView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JadawlKList(widget.cek),
    );
  }
}

class JadawlKList extends StatelessWidget {
  final bool cek;

  JadawlKList(this.cek);
  @override
  Widget build(BuildContext context) {
    final jadwalkdata = Provider.of<JadwalHariIni>(context);
    final jadwalk = jadwalkdata.items ?? [];

    return Container(
      color: mainBgColor,
      child: CarouselSlider.builder(
          options: CarouselOptions(
            reverse: true,
            height: 150,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            viewportFraction: 0.8,
          ),
          itemCount: jadwalk.length > 0 ? jadwalk.length : 1,
          itemBuilder: cek == true
              ? (context, index, realindex) => ShimmerSemesterItem()
              : jadwalk.length > 0
                  ? (context, index, realindex) => JadwalItem(jadwalk[index])
                  : (context, index, realindex) => JadwalKosongItem()),
    );
  }
}
