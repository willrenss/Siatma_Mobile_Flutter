import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/jadwal_api.dart';

import 'package:siatma_mobile/components/colors.dart';

import 'package:siatma_mobile/widget/jadwalkWidget.dart';
import 'package:siatma_mobile/widget/jadwaluWidget.dart';
import 'package:siatma_mobile/widget/semesterJadwalWidget.dart';

import 'package:siatma_mobile/widget/waktuKWidget.dart';
import 'package:siatma_mobile/widget/waktuUWidget.dart';

class JadwalScreen extends StatefulWidget {
  @override
  _JadwalScreenState createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State with SingleTickerProviderStateMixin {
  bool isVisible = true;
  final List<Tab> myTabs = <Tab>[
    new Tab(text: 'Kuliah'),
    new Tab(text: 'Ujian'),
  ];
  TabController tabController;
  // ignore: unused_field
  bool _firstSearch = true;

  @override
  void initState() {
    Provider.of<WaktuKP>(context, listen: false).fetchWaktuK();
    Provider.of<WaktuUP>(context, listen: false).fetchWaktuU();
    isVisible = true;
    tabController =
        new TabController(vsync: this, length: myTabs.length, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: blueatmacolor,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.alarm),
            onPressed: () {
              SnackBar snackBar = SnackBar(
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.white.withOpacity(0.5),
                  duration: Duration(milliseconds: 1000),
                  content: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      height: 180,
                      child: !isVisible
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      'Waktu Ujian',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: "Lato",
                                        color: blueatmacolor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(child: WaktuUView()),
                              ],
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      'Waktu Kuliah',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: "Lato",
                                        color: blueatmacolor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(child: WaktuKView()),
                              ],
                            )));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
        elevation: 0,
        backgroundColor: blueatmacolor,
        title: Text("Jadwal"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            _buildRegionTabBar(myTabs, tabController),
            _menu(),
            if (isVisible) _kuliah(),
            if (!isVisible) _ujian()
          ],
        ),
      ),
    );
  }

  SliverPadding _menu() {
    return SliverPadding(
      padding: EdgeInsets.only(top: 0),
      sliver: SliverToBoxAdapter(
        child: Container(
          color: blueatmacolor,
          height: 25,
          width: 100,
          child: SemesterJadwalview(),
        ),
      ),
    );
  }

  SliverPadding _kuliah() {
    return SliverPadding(
        padding: const EdgeInsets.only(top: 20.0),
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
                  padding: EdgeInsets.only(right: 5, left: 5, top: 20),
                  height: MediaQuery.of(context).size.height - 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    height: MediaQuery.of(context).size.height - 295,
                    child: JadwalKView(),
                  ),
                ))));
  }

  SliverPadding _ujian() {
    return SliverPadding(
        padding: const EdgeInsets.only(top: 20.0),
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
                  padding: EdgeInsets.only(right: 5, left: 5),
                  height: MediaQuery.of(context).size.height - 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 35),
                        // SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(color: Colors.white),
                          height: MediaQuery.of(context).size.height - 295,
                          child: JadwalUView(),
                        )
                      ],
                    ),
                  ),
                ))));
  }

  SliverToBoxAdapter _buildRegionTabBar(
      List<Tab> mytabs, TabController tabController) {
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
                  print(index);
                  isVisible = true;
                });
              }
              if (index == 1) {
                setState(() {
                  print(index);
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
