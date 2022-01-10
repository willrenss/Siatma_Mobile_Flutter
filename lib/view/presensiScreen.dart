import 'package:flutter/material.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/widget/presensiWidget.dart';
import 'package:siatma_mobile/widget/semesterWidget.dart';

class PresensiScreen extends StatefulWidget {
  @override
  _PresensiScreenState createState() => _PresensiScreenState();
}

class _PresensiScreenState extends State {
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
        title: Text("Presensi"),
        centerTitle: true,
      ),
      body: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[_menu(), _presensi()],
      ),
    );
  }

  SliverPadding _menu() {
    return SliverPadding(
      padding: EdgeInsets.only(top: 0, bottom: 10),
      sliver: SliverToBoxAdapter(
        child: Container(
          color: blueatmacolor,
          height: 25,
          width: 100,
          child: Semesterview(),
        ),
      ),
    );
  }

  SliverPadding _presensi() {
    return SliverPadding(
        padding: const EdgeInsets.only(top: 10.0),
        sliver: SliverToBoxAdapter(
          child: Container(
            height: MediaQuery.of(context).size.height - 100,
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
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.only(right: 5, left: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height - 150,
                  child: PresensiView(),
                ),
              ],
            ),
          ),
        ));
  }
}
