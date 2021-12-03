import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/dhs_api.dart';
import 'package:siatma_mobile/item/dhs.dart';
import 'package:siatma_mobile/item/shimmer.dart';

import 'package:siatma_mobile/model/daftarhasilstudi_model.dart';

class DHSview extends StatefulWidget {
  final String query;

  DHSview(this.query);

  @override
  _DHSviewState createState() => _DHSviewState();
}

class _DHSviewState extends State<DHSview> {
  @override
  void initState() {
    Provider.of<DaftarHS>(context, listen: false).fetchDHS();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DHSList(query: widget.query),
    );
  }
}

class DHSList extends StatefulWidget {
  final String query;

  DHSList({Key key, @required this.query}) : super(key: key);

  @override
  _DHSListState createState() => _DHSListState();
}

class _DHSListState extends State<DHSList> {
  @override
  Widget build(BuildContext context) {
    if (widget.query == "") {
      final dhsData = Provider.of<DaftarHS>(context);
      final dhs = dhsData.items;
      return Container(
        color: Colors.white,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: dhs.length > 0
              ? AlwaysScrollableScrollPhysics()
              : NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(10.0),
          itemCount: dhs.length > 0 ? dhs.length : 6,
          itemBuilder: (ctx, i) =>
              dhs.length > 0 ? DHSItem(dhs[i]) : ShimmerItem(130),
        ),
      );
    } else {
      final dhsData = Provider.of<DaftarHS>(context);
      final dhs1 = dhsData.items;
      final dhs = _performSearch(dhs1, widget.query);
      return Container(
        color: Colors.white,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: dhs.length > 0
              ? AlwaysScrollableScrollPhysics()
              : NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(10.0),
          itemCount: dhs.length > 0 ? dhs.length : 6,
          itemBuilder: (ctx, i) =>
              dhs.length > 0 ? DHSItem(dhs[i]) : ShimmerItem(130),
        ),
      );
    }
  }

  List<DHS> _performSearch(List<DHS> dhs, String _query) {
    List<DHS> _filterList = [];
    for (int i = 0; i < dhs.length; i++) {
      final item = dhs[i];

      if (item.matakuliah.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
      }
    }
    return _filterList;
  }
}
