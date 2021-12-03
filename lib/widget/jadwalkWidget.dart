import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/jadwal_api.dart';
import 'package:siatma_mobile/item/jadwalK.dart';
import 'package:siatma_mobile/item/shimmer.dart';

class JadwalKView extends StatefulWidget {
  @override
  _JadwalKViewState createState() => _JadwalKViewState();
}

class _JadwalKViewState extends State<JadwalKView> {
  @override
  void initState() {
    Provider.of<JadwalKP>(context, listen: false).fetchJadwalK();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JadawlKList(),
    );
  }
}

class JadawlKList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final jadwalkdata = Provider.of<JadwalKP>(context);
    final jadwalk = jadwalkdata.items;

    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(10.0),
        physics: jadwalk.length > 0
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        itemCount: jadwalk.length > 0 ? jadwalk.length : 6,
        itemBuilder: jadwalk.length > 0
            ? (ctx, i) => JadwalKItem(jadwalk[i])
            : (ctx, i) => ShimmerItem(200),
      ),
    );
  }
}
