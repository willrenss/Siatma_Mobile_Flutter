import 'package:auto_size_text/auto_size_text.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/dhs_api.dart';
import 'package:siatma_mobile/api/khs_api.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/widget/dhsWidget.dart';
import 'package:siatma_mobile/widget/khswWidget.dart';
import 'package:siatma_mobile/widget/semesterWidget.dart';

class NilaiScreen extends StatefulWidget {
  @override
  _NilaiScreenState createState() => _NilaiScreenState();
}

class _NilaiScreenState extends State with SingleTickerProviderStateMixin {
  bool isVisible = true;
  var _searchview = new TextEditingController();
  var text = AutoSizeGroup();
  final List<Tab> myTabs = <Tab>[
    new Tab(text: 'KHS'),
    new Tab(text: 'DHS'),
  ];
  TabController tabController;
  // ignore: unused_field
  bool _firstSearch = true;

  String _query = "";
  @override
  void initState() {
    isVisible = true;

    tabController =
        new TabController(vsync: this, length: myTabs.length, initialIndex: 0);
    super.initState();
  }

  _NilaiScreenState() {
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        setState(() {
          _firstSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
          print(_searchview);
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final ipsData = Provider.of<IPSP>(context);
    final ips = ipsData.items;

    // print(jatah[0].sks_diambil);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: blueatmacolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: blueatmacolor,
        title: Text("Nilai"),
        centerTitle: true,
      ),
      body: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            _buildRegionTabBar(myTabs, tabController),
            if (isVisible) _menu(),
            if (isVisible) _khs(ips),
            if (!isVisible) _dhs(),
          ],
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

  SliverPadding _dhs() {
    return SliverPadding(
        padding: const EdgeInsets.only(top: 5.0),
        sliver: SliverToBoxAdapter(
            child: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity > 0) {
              // User swiped Left
              setState(() {
                isVisible = true;
                tabController.index = 0;
              });
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.height - 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            clipBehavior: Clip.none,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20.0),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Daftar Hasil Studi',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: "Lato",
                        color: blueatmacolor,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                      color: blueatmacolor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    height: 40,
                    child: TextFormField(
                      controller: _searchview,
                      style: TextStyle(color: Colors.white),
                      autofocus: false,
                      cursorColor: Colors.white30,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          child: Icon(Icons.search, color: Colors.white),
                        ),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        isDense: true,
                        border: new OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(32.0)),
                        hintText: 'Cari Mata Kuliah',
                        hintStyle: TextStyle(color: Colors.white30),
                        labelStyle: TextStyle(color: Color(0xFFeca81e)),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(color: Colors.white),
                  height: MediaQuery.of(context).size.height - 265,
                  child: ChangeNotifierProvider(
                    create: (ctx) => DaftarHS(),
                    child: DHSview(
                      _query,
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }

  SliverPadding _khs(final ips) {
    return SliverPadding(
        padding: const EdgeInsets.only(top: 10.0),
        sliver: SliverToBoxAdapter(
            child: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity < 0) {
              // User swiped Right
              setState(() {
                isVisible = false;
                tabController.index = 1;
              });
            }
          },
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
              children: <Widget>[
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(top: 20.0),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Kartu Hasil Studi',
                          style: const TextStyle(
                            fontFamily: "Lato",
                            color: blueatmacolor,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  child: Row(
                    children: [
                      Flexible(
                        child: Center(
                          child: Container(
                            child: AutoSizeText(
                              ips.length > 0
                                  ? "IPS :" + " ${ips[0].ips}"
                                  : "IPS : - ",
                              style: const TextStyle(
                                fontFamily: "Lato",
                                color: blueatmacolor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              group: text,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Center(
                          child: Container(
                              child: AutoSizeText(
                            ips.length > 0
                                ? "SKS :" + " ${ips[0].sks}"
                                : "SKS : - ",
                            style: const TextStyle(
                              fontFamily: "Lato",
                              color: blueatmacolor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            group: text,
                            maxLines: 1,
                          )),
                        ),
                      ),
                      Flexible(
                        child: Center(
                          child: Container(
                              child: AutoSizeText(
                            ips.length > 0
                                ? ips[0].ips >= 3
                                    ? "Jatah SKS :" + " 24"
                                    : "Jatah SKS : 21 "
                                : "Jatah SKS : - ",
                            style: const TextStyle(
                              fontFamily: "Lato",
                              color: blueatmacolor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            group: text,
                            maxLines: 1,
                          )),
                        ),
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(color: Colors.white),
                  height: MediaQuery.of(context).size.height - 285,
                  child: KHSview(),
                )
              ],
            ),
          ),
        )));
  }

  SliverToBoxAdapter _buildRegionTabBar(
      final List<Tab> myTabs, TabController tabController) {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            controller: tabController,
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            labelColor: blueatmacolor,
            unselectedLabelColor: Colors.white,
            tabs: myTabs,
            onTap: (index) {
              if (index == 0) {
                setState(() {
                  isVisible = true;
                });
              }
              if (index == 1) {
                setState(() {
                  isVisible = false;
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
