import 'package:masterbagasi/data/pembawa.dart';
import 'package:masterbagasi/data/penitip.dart';

class Barang
{
  String id;
  Penitip penitip;
  Pembawa pembawa;
  String password;

  Barang({this.id, this.penitip, this.pembawa, this.password});
}