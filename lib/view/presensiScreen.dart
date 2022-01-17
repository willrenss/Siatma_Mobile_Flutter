import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/presensi_api.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/widget/presensiWidget.dart';
import 'package:siatma_mobile/widget/semesterWidget.dart';

class PresensiScreen extends StatefulWidget {
  @override
  _PresensiScreenState createState() => _PresensiScreenState();
}

class _PresensiScreenState extends State {
  bool cek;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    cek = Provider.of<PresensiP>(context, listen: true).kondisipresensi;
    super.didChangeDependencies();
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
            child: cek == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(right: 100, left: 80, bottom: 30),
                        child: Image.asset("assets/images/Nodata.png",
                            fit: BoxFit.contain),
                      ),
                      Container(
                        child: AutoSizeText("Data Tidak Ditemukan",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: blueatmacolor,
                              fontWeight: FontWeight.w700,
                            )),
                      )
                    ],
                  )
                : Column(
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
