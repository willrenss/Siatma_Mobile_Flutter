import 'package:flutter/material.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/widget/pembayaranWidget.dart';

class PembayaranScreen extends StatefulWidget {
  @override
  _PembayaranScreenState createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: blueatmacolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: blueatmacolor,
        title: Text("Pembayaran"),
        centerTitle: true,
      ),
      body:CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[_pembayaran()],
        ),
      
    );
  }

  SliverPadding _pembayaran() {
    return SliverPadding(
        padding: const EdgeInsets.only(top: 10.0),
        sliver: SliverToBoxAdapter(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(right: 5, left: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height - 115,
                  child: PembayaranView(),
                ),
              ],
            ),
          ),
        ));
  }
}
