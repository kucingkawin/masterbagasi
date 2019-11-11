import 'package:masterbagasi/data/pembawa.dart';
import 'package:masterbagasi/data/penitip.dart';

class Order
{
  String id;
  Penitip penitip;
  Pembawa pembawa;
  DateTime tanggal;

  Order({this.id, this.penitip, this.pembawa, this.tanggal});
}