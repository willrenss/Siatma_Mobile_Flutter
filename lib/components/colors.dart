import 'package:flutter/material.dart';

const mainBgColor = Color(0xFFf2f2f2);
const darkColor = Color(0xFF013557);
const darkColor2 = Color(0xFF003c63);
const midColor = Color(0xFF522349);
const lightColor = Color(0xFF0091f0);
const darkRedColor = Color(0xFFFA695C);
const lightRedColor = Color(0xFFFD685A);
const blueatmacolor = Color(0xFF00578f);
const lightblueatma = Color(0xFF006db3);
const yellowatmacolor = Color(0xFFeca81e);
const fotobirucolor = Color(0xFF1158bc);

const blueGradient = LinearGradient(
  colors: <Color>[darkColor, blueatmacolor, darkColor],
  stops: [0.1, 2.0, 1.0],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const blueGradient2 = LinearGradient(
  colors: <Color>[blueatmacolor, darkColor2, darkColor2],
  stops: [0.1, 2.0, 1.0],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
const redGradient = LinearGradient(
  colors: <Color>[darkRedColor, lightRedColor],
  stops: [0.0, 1.0],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const USER_IMAGE =
    'https://cdn4.iconfinder.com/data/icons/people-avatar-flat-1/64/girl_chubby_beautiful_people_woman_lady_avatar-512.png';
