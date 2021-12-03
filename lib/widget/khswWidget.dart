import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/khs_api.dart';
import 'package:siatma_mobile/item/khs.dart';
import 'package:siatma_mobile/item/shimmer.dart';

class KHSview extends StatefulWidget {
  @override
  _KHSviewState createState() => _KHSviewState();
}

class _KHSviewState extends State<KHSview> {
  @override
  void initState() {
    Provider.of<KartuHS>(context, listen: false).fetchKHS();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: KHSList(),
    );
  }
}

class KHSList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final khsData = Provider.of<KartuHS>(context);
    final khs = khsData.items ?? [];

    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: khs.length > 0
          ? AlwaysScrollableScrollPhysics()
          : NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      itemCount: khs.length > 0 ? khs.length : 3,
      itemBuilder: khs.length > 0
          ? (ctx, i) => KHSItem(khs[i])
          : (ctx, i) => ShimmerItem(220),
    );
  }
}
