import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/mahasiswa_api.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/item/berita.dart';
import 'package:siatma_mobile/item/shimmer.dart';

class BeritaView extends StatefulWidget {
  @override
  _BeritaViewState createState() => _BeritaViewState();
}

class _BeritaViewState extends State<BeritaView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BeritaList(),
    );
  }
}

class BeritaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final beritadata = Provider.of<BeritaP>(context);
    final berita = beritadata.items;

    return Container(
        color: mainBgColor,
        child: CarouselSlider.builder(
            options: CarouselOptions(
                height: 150,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: Duration(seconds: 2),
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 200),
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 0.7),
            itemCount: berita.length > 0 ? berita.length : 5,
            itemBuilder: berita.length <= 0
                ? (context, index, realindex) => ShimmerItem(200)
                : (context, index, realindex) => BeritaItem(berita[index])));
  }
}
