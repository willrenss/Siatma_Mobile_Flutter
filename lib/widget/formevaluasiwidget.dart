import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/formevaluasi_api.dart';
import 'package:siatma_mobile/item/formE.dart';
import 'package:siatma_mobile/item/shimmer.dart';

class FormEvaluasiView extends StatefulWidget {
  @override
  _FormEvaluasiViewState createState() => _FormEvaluasiViewState();
}

class _FormEvaluasiViewState extends State<FormEvaluasiView> {
  @override
  void initState() {
    Provider.of<MatakuliahEP>(context, listen: false).fetchMatakuliahEP();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FormEvaluasiList(),
    );
  }
}

class FormEvaluasiList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final matakuliahEData = Provider.of<MatakuliahEP>(context);
    final matakuliah = matakuliahEData.items ?? [];

    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: matakuliah.length > 0
          ? AlwaysScrollableScrollPhysics()
          : NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      itemCount: matakuliah.length > 0 ? matakuliah.length : 6,
      itemBuilder: matakuliah.length > 0
          ? (ctx, i) => FormEItem(matakuliah[i])
          : (ctx, i) => ShimmerItem(150),
    );
  }
}
