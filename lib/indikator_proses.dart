import 'package:flutter/material.dart';

class IndikatorProses extends StatefulWidget {
  IndikatorProses({Key key, this.daftarProses, this.indeksProses, this.warna}) : super(key: key);

  static IndikatorProsesState of(BuildContext context)
  {
    return context.ancestorStateOfType(TypeMatcher<IndikatorProsesState>());
  }

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final List<String> daftarProses;
  final int indeksProses;
  final Color warna;

  @override
  IndikatorProsesState createState() => IndikatorProsesState();
}

class IndikatorProsesState extends State<IndikatorProses> {

  @override
  void initState()
  {
    super.initState();
  }

  @override
  void didUpdateWidget(IndikatorProses oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return CustomPaint(
      size: Size(double.infinity, 100.0),
      painter: IndikatorProsesPainter(widget.daftarProses, widget.indeksProses, widget.warna),
    );
  }
}

class IndikatorProsesPainter extends CustomPainter
{
  Paint objectPaintBulat;
  Paint objectPaintLatar;
  Paint objectPaintGaris;
  Paint objectPaintKotakTeks;
  List<String> daftarLangkah;
  int indeksLangkahSaatIni;
  Color warna;
  //BuildContext context;

  IndikatorProsesPainter(this.daftarLangkah, this.indeksLangkahSaatIni, this.warna) {
    objectPaintBulat = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    objectPaintLatar = Paint()
      ..color = Colors.grey[200]
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    objectPaintGaris = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    objectPaintKotakTeks = Paint()
      ..color = warna
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromPoints(Offset(0.0, 0.0), Offset(size.width, size.height)), objectPaintLatar);

    //Banyaknya langkah;
    int banyakLangkah = daftarLangkah.length;
    int banyakJarak = banyakLangkah - 1;
    double diameter = 25.0;
    double sisi = size.width / banyakLangkah;
    double jarakLebarKonten = 12.0;

    //Tentukan titik dasar
    double jarakAntarLingkaran = (size.width - diameter * banyakLangkah - sisi * 2) / banyakJarak;
    double titikAwalX = sisi / 2.0;
    double titikAwalXTerakhir = titikAwalX;
    double lebarMaksimalTeks = 0.0;

    //Untuk pengaturan style teks.
    List<TextPainter> daftarTextPainter = List<TextPainter>();
    for(int i = 0; i < banyakLangkah; i++)
    {
      bool sedangDalamLangkahSaatIni = i <= indeksLangkahSaatIni;

      //Pengaturan style teks.
      final textStyle = TextStyle(
        color: sedangDalamLangkahSaatIni ? this.warna : Colors.grey,
        fontWeight: sedangDalamLangkahSaatIni ? FontWeight.bold : FontWeight.normal,
        fontSize: 11
      );

      //Pengaturan teks span.
      final textSpan = TextSpan(
        text: daftarLangkah[i],
        style: textStyle,
      );

      //Pengaturan text painter.
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(maxWidth: sisi - 20.0);
      if(textPainter.height > lebarMaksimalTeks)
        lebarMaksimalTeks = textPainter.height;

      daftarTextPainter.add(textPainter);
    }

    //A + 2B = C; B = (C - A) / 2
    //A = diameter + 12.0 + teksHeight
    double lebarKeseluruhanKonten = diameter + jarakLebarKonten + lebarMaksimalTeks;
    double sisiTepiY = (size.height - lebarKeseluruhanKonten) / 2;
    double titikY = sisiTepiY + lebarKeseluruhanKonten / 2;
    double titikYLingkaran = titikY - (diameter / 2.0) - (jarakLebarKonten / 2.0);
    double deltaYTepiLingkaran = sisiTepiY - (titikYLingkaran - diameter / 2.0);
    titikY += deltaYTepiLingkaran;
    titikYLingkaran = titikY - (diameter / 2.0) - (jarakLebarKonten / 2.0);
    for(int i = 0; i < banyakLangkah; i++)
    {
      bool sedangDalamLangkahSaatIni = i <= indeksLangkahSaatIni;

      //Gambar garis (jika kotak ke 2 dan seterusnya)
      if(i > 0)
        canvas.drawLine(Offset(titikAwalX - diameter / 2.0, titikYLingkaran), Offset(titikAwalXTerakhir + diameter / 2.0, titikYLingkaran), objectPaintGaris);

      //Gambar lingkaran.
      canvas.drawCircle(Offset(titikAwalX, titikYLingkaran), diameter / 2.0, sedangDalamLangkahSaatIni ? objectPaintKotakTeks : objectPaintBulat);

      //Tentukan offset teks.
      final maxLebarTeks = 26.0;
      Offset offsetTeks = Offset(titikAwalX - daftarTextPainter[i].width / 2.0, titikY + (jarakLebarKonten / 2.0));
      double selisihLebarTeks = maxLebarTeks - daftarTextPainter[i].height;
      offsetTeks = offsetTeks.translate(0.0, selisihLebarTeks / 2.0);
      final offsetKotakTeksAwal = Offset(offsetTeks.dx - 5.0, offsetTeks.dy - 5.0);
      final offsetKotakTeksAkhir = Offset(offsetTeks.dx + daftarTextPainter[i].width + 5.0, offsetTeks.dy + daftarTextPainter[i].height + 5.0);

      /*if(sedangDalamLangkahSaatIni)
        canvas.drawRect(Rect.fromPoints(offsetKotakTeksAwal, offsetKotakTeksAkhir), objectPaintKotakTeks);*/

      //Gambar teks.
      daftarTextPainter[i].paint(canvas, Offset(offsetTeks.dx ,offsetTeks.dy));

      //Tentukan titik awal x dan historynya.
      titikAwalXTerakhir = titikAwalX;
      titikAwalX += sisi;
    }
  }

  @override
  bool shouldRepaint(IndikatorProsesPainter oldDelegate) {
    return oldDelegate.indeksLangkahSaatIni != indeksLangkahSaatIni;
  }

}