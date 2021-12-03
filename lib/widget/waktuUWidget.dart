import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/jadwal_api.dart';
import 'package:siatma_mobile/item/waktuU.dart';

class WaktuUView extends StatefulWidget {
  @override
  _WaktuUViewState createState() => _WaktuUViewState();
}

class _WaktuUViewState extends State<WaktuUView> {
  @override
  void initState() {
    Provider.of<WaktuUP>(context, listen: false).fetchWaktuU();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      resizeToAvoidBottomInset: false,
      body: WaktuUList(),
    );
  }
}

class WaktuUList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final waktuUdata = Provider.of<WaktuUP>(context);
    final waktuU = waktuUdata.items;

    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(10.0),
        itemCount: waktuU.length,
        itemBuilder: (ctx, i) => WaktuUItem(waktuU[i]),
      ),
    );
  }
}
