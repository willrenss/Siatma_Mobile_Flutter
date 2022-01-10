import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/formevaluasi_api.dart';
import 'package:siatma_mobile/api/mahasiswa_api.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/view/homeScreen.dart';
import 'package:siatma_mobile/view/jadwalScreen.dart';
import 'package:siatma_mobile/view/profileScreen.dart';

class DashboardScreen extends StatefulWidget {
  final bool fromcek;

  DashboardScreen(this.fromcek);
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  List _listScreens;

  @override
  void initState() {
    super.initState();
    _selectedIndex = Provider.of<MahasiswaP>(context, listen: false).indexs;
    if (Provider.of<MahasiswaP>(context, listen: false).touchs == 0) {
      Provider.of<MatakuliahEP>(context, listen: false).fetchMatakuliahEP();
      Provider.of<BeritaP>(context, listen: false).fetchBerita();
      Provider.of<FormEP>(context, listen: false).fetchKusioner();
      Provider.of<Info>(context, listen: false).fetchInfo();
      Provider.of<SKSMATP>(context, listen: false).fetchSKSMAT();
    }

    setState(() {
      if (widget.fromcek == true) {
        _listScreens = [
          HomeScreen(true),
          JadwalScreen(),
          ProfileScreen(),
        ];
      } else {
        _listScreens = [
          HomeScreen(false),
          JadwalScreen(),
          ProfileScreen(),
        ];
      }
    });
  }

  @override
  void didChangeDependencies() {
    Provider.of<MahasiswaP>(context, listen: false).fetchMahasiswa();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listScreens[_selectedIndex],
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBackgroundColor: blueatmacolor,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
        ),
        selectedIndex: _selectedIndex,
        onSelectTab: (index) {
          setState(() {
            _selectedIndex = index;
            Provider.of<MahasiswaP>(context, listen: false).setIndex(index);
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.dashboard,
            label: 'Dashboard',
          ),
          FFNavigationBarItem(
            iconData: Icons.calendar_today,
            label: 'Jadwal',
          ),
          FFNavigationBarItem(
            iconData: Icons.account_circle,
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
