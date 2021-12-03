import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/formevaluasi_api.dart';
import 'package:siatma_mobile/item/detailE.dart';
import 'package:siatma_mobile/item/shimmer.dart';

class DetailEvaluasiView extends StatefulWidget {
  @override
  _DetailEvaluasiViewState createState() => _DetailEvaluasiViewState();
}

class _DetailEvaluasiViewState extends State<DetailEvaluasiView> {
  @override
  void initState() {
    Provider.of<PertanyaanEP>(context, listen: false).fetchPertanyaan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DetailEvaluasiList(),
    );
  }
}

class DetailEvaluasiList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pertanyaanEData = Provider.of<PertanyaanEP>(context);
    final pertanyaan = pertanyaanEData.items ?? [];

    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: pertanyaan.length > 0
          ? AlwaysScrollableScrollPhysics()
          : NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      itemCount: pertanyaan.length > 0 ? pertanyaan.length : 6,
      itemBuilder: pertanyaan.length > 0
          ? (ctx, i) => PertanyaanItem(pertanyaan[i])
          : (ctx, i) => ShimmerItem(150),
    );
  }
}
