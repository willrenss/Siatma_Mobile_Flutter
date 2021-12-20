import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siatma_mobile/components/colors.dart';

import 'package:siatma_mobile/model/semester_model.dart';

class SemesterItem extends StatefulWidget {
  final Semester semesteraka;
  final int semester;
  final int current;
  final int index;

  SemesterItem(this.semesteraka, this.semester, this.current, this.index);

  @override
  _SemesterItemState createState() => _SemesterItemState();
}

class _SemesterItemState extends State<SemesterItem> {
  bool color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width + 100,
      decoration: BoxDecoration(
        color: widget.current == widget.index ? Colors.white : Colors.white24,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Center(
          child: FittedBox(
              fit: BoxFit.fitWidth,
              child: AutoSizeText(
                  widget.semester != 0
                      ? "${widget.semesteraka.semesterakademik} [ ${widget.semester} ]"
                      : "",
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: widget.current == widget.index
                          ? blueatmacolor
                          : Colors.white))),
        ),
      ),
    );
  }
}

class ShimmerSemesterItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        highlightColor: Colors.grey[100],
        baseColor: Colors.grey[300],
        child: Container(
          width: MediaQuery.of(context).size.width + 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ));
  }
}
