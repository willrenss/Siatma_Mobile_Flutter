class Semester {
  final String semesterakademik;

  Semester({this.semesterakademik});

  factory Semester.fromJson(Map<List, dynamic> json) {
    return Semester(semesterakademik: json['SEMESTER_AKADEMIk'].toString());
  }
}
