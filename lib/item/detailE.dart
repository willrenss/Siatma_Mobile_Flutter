import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/formevaluasi_api.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/model/formevaluasi_model.dart';

class PertanyaanItem extends StatefulWidget {
  final Pertanyaan pertanyaan;

  PertanyaanItem(this.pertanyaan);

  @override
  State<PertanyaanItem> createState() => _PertanyaanItemState();
}

class _PertanyaanItemState extends State<PertanyaanItem> {
  int val = 0;
  int index = 0;
  var komentar = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      if (Provider.of<DetailJawabanEP>(context, listen: false)
              .findById(widget.pertanyaan.idpertanyaan) !=
          null)
        val = Provider.of<DetailJawabanEP>(context, listen: false)
            .nilai(widget.pertanyaan.idpertanyaan);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.dstATop),
              image: ExactAssetImage('assets/images/nilaiback.jpg'),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
            color: blueatmacolor,
            borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(vertical: 5),
        width: MediaQuery.of(context).size.width - 390,
        child: Theme(
            data: ThemeData(
              toggleableActiveColor: Colors.green[400],
              //here change to your color
              unselectedWidgetColor: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "${widget.pertanyaan.nomor}",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Text(
                        "${widget.pertanyaan.soal}",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                if (widget.pertanyaan.idjenispertanyaan == 3)
                  Container(
                    child: Column(
                      children: widget.pertanyaan.jawaban
                          .map((data) => RadioListTile(
                                activeColor: Colors.green[400],
                                title: Text(
                                  "${data.text}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                groupValue: val,
                                value: data.nilai,
                                onChanged: (value) {
                                  setState(() {
                                    val = value;
                                    Provider.of<DetailJawabanEP>(context,
                                            listen: false)
                                        .fetchJawaban(DetailJawabanE(
                                            idpertanyaan:
                                                widget.pertanyaan.idpertanyaan,
                                            detailjawaban: data.text,
                                            detailjawabannilai: data.nilai));
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ),
                if (widget.pertanyaan.idjenispertanyaan == 1)
                  SizedBox(height: 15),
                if (widget.pertanyaan.idjenispertanyaan == 1)
                  Container(
                    child: TextFormField(
                      controller: komentar,
                      onChanged: (value) {
                        setState(() {
                          print(value);
                          Provider.of<DetailJawabanEP>(context, listen: false)
                              .fetchJawaban(DetailJawabanE(
                                  idpertanyaan: widget.pertanyaan.idpertanyaan,
                                  detailjawaban: value,
                                  detailjawabannilai:
                                      widget.pertanyaan.jawaban[0].nilai));
                        });
                      },
                      autofocus: false,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(32.0)),
                        hintText: 'Komentar',
                        labelStyle: TextStyle(color: Color(0xFFa67717)),
                      ),
                    ),
                  )
              ],
            )));
  }
}
