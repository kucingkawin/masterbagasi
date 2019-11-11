import 'package:flutter/material.dart';

class IndikatorBar extends StatefulWidget {
  IndikatorBar({Key key, this.value, this.maxValue, this.minValue, this.warna}) : super(key: key);

  static String route = 'utama/detail-barang';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final double value;
  final double maxValue;
  final double minValue;
  final Color warna;

  @override
  IndikatorBarState createState() => IndikatorBarState();
}

class IndikatorBarState extends State<IndikatorBar> {

  @override
  void initState()
  {
    super.initState();
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
      size: Size(double.infinity, 5.0),
      painter: IndikatorBarPainter(widget.value, widget.maxValue, widget.minValue, widget.warna),
    );
  }
}

class IndikatorBarPainter extends CustomPainter
{
  Paint objectPaintLatar;
  Paint objectPaintIsi;

  final double value;
  final double maxValue;
  final double minValue;
  final Color warna;

  IndikatorBarPainter(this.value, this.maxValue, this.minValue, this.warna) {
    objectPaintLatar = Paint()
      ..color = Colors.grey[350]
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    objectPaintIsi = Paint()
      ..color = warna
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double normalisasi = (value - minValue) / (maxValue - minValue);
    canvas.drawRect(Rect.fromPoints(Offset(0.0, 0.0), Offset(size.width, size.height)), objectPaintLatar);
    canvas.drawRect(Rect.fromPoints(Offset(0.0, 0.0), Offset(size.width * normalisasi, size.height)), objectPaintIsi);
  }

  @override
  bool shouldRepaint(IndikatorBarPainter oldDelegate) {
    return oldDelegate.value != value || oldDelegate.warna != warna;
  }

}