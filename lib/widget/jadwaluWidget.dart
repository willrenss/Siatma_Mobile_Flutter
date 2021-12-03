import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/jadwal_api.dart';
import 'package:siatma_mobile/item/jadwalU.dart';
import 'package:siatma_mobile/item/shimmer.dart';

class JadwalUView extends StatefulWidget {
  @override
  _JadwalKViewState createState() => _JadwalKViewState();
}

class _JadwalKViewState extends State<JadwalUView> {
  @override
  void initState() {
    Provider.of<JadwalUP>(context, listen: false).fetchJadwalU();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JadwalUList(),
    );
  }
}

class JadwalUList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final jadwalUdata = Provider.of<JadwalUP>(context);
    final jadwalu = jadwalUdata.items;

    return Container(
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: jadwalu.length > 0
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        itemCount: jadwalu.length > 0 ? jadwalu.length : 6,
        itemBuilder: jadwalu.length > 0
            ? (ctx, i) => JadwalUItem(jadwalu[i])
            : (ctx, i) => ShimmerItem(150),
      ),
    );
  }
}
