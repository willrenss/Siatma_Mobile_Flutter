import 'package:flutter/material.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/widget/formevaluasiwidget.dart';

class FormEvaluasiScreen extends StatefulWidget {
  @override
  _FormEvaluasiScreenState createState() => _FormEvaluasiScreenState();
}

class _FormEvaluasiScreenState extends State {
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
        title: Text("Form Evaluasi Dosen"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[_formEvaluasi()],
        ),
      ),
    );
  }

  SliverPadding _formEvaluasi() {
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
                  height: MediaQuery.of(context).size.height - 115,
                  child: FormEvaluasiView(),
                ),
              ],
            ),
          ),
        ));
  }
}
