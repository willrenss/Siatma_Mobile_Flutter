import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/pembayaran_api.dart';
import 'package:siatma_mobile/item/pembayaran.dart';

import 'package:siatma_mobile/item/shimmer.dart';

class PembayaranView extends StatefulWidget {
  @override
  _PembayaranViewState createState() => _PembayaranViewState();
}

class _PembayaranViewState extends State<PembayaranView> {
  @override
  void initState() {
    Provider.of<PembayaranP>(context, listen: false).fetchPembayaran();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PembayaranList(),
    );
  }
}

class PembayaranList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pembayaranData = Provider.of<PembayaranP>(context);
    final pemabayaran = pembayaranData.items ?? [];

    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: pemabayaran.length > 0
          ? AlwaysScrollableScrollPhysics()
          : NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      itemCount: pemabayaran.length > 0 ? pemabayaran.length : 3,
      itemBuilder: pemabayaran.length > 0
          ? (ctx, i) => PembayaranItem(pemabayaran[i])
          : (ctx, i) => ShimmerItem(220),
    );
  }
}
