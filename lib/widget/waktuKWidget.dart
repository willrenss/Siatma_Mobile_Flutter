import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/jadwal_api.dart';
import 'package:siatma_mobile/item/waktuK.dart';

class WaktuKView extends StatefulWidget {
  @override
  _WaktuKViewState createState() => _WaktuKViewState();
}

class _WaktuKViewState extends State<WaktuKView> {
  @override
  void initState() {
    Provider.of<WaktuKP>(context, listen: false).fetchWaktuK();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      resizeToAvoidBottomInset: false,
      body: WaktuKList(),
    );
  }
}

class WaktuKList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final waktuKdata = Provider.of<WaktuKP>(context);
    final waktuK = waktuKdata.items;

    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(10.0),
        itemCount: waktuK.length,
        itemBuilder: (ctx, i) => WaktuKItem(waktuK[i]),
      ),
    );
  }
}
