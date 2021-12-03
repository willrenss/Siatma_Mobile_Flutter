import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/presensi_api.dart';

import 'package:siatma_mobile/item/presensis.dart';

import 'package:siatma_mobile/item/shimmer.dart';

class PresensiView extends StatefulWidget {
  @override
  _PresensiViewState createState() => _PresensiViewState();
}

class _PresensiViewState extends State<PresensiView> {
  @override
  void initState() {
    Provider.of<PresensiP>(context, listen: false).fetchPresensi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PresensiList(),
    );
  }
}

class PresensiList extends StatefulWidget {
  @override
  State<PresensiList> createState() => _PresensiListState();
}

class _PresensiListState extends State<PresensiList> {
  @override
  Widget build(BuildContext context) {
    final presensiData = Provider.of<PresensiP>(context);
    final presensi = presensiData.items ?? [];

    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: presensi.length > 0
          ? AlwaysScrollableScrollPhysics()
          : NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      itemCount: presensi.length > 0 ? presensi.length : 6,
      itemBuilder: presensi.length > 0
          ? (ctx, i) => PresensiItem(presensi[i])
          : (ctx, i) => ShimmerItem(110),
    );
  }
}
