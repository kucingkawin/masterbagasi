import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masterbagasi/data/keranjang.dart';
import 'package:masterbagasi/data/sampel.dart';

class KeranjangPage extends StatefulWidget {
  KeranjangPage({Key key, this.title}) : super(key: key);

  static String route = 'keranjang';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _KeranjangPageState createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {

  TextEditingController _controllerPencarian = TextEditingController();
  int _bottomNavCurrentIndex = 0;
  bool dalamPemilihan;
  List<Keranjang> listKeranjangDipilih;

  @override
  void initState() {
    dalamPemilihan = false;

    listKeranjangDipilih = List<Keranjang>();
  }

  @override
  Widget build(BuildContext context) {

    TextField teksPencarian = TextField(
      controller: _controllerPencarian,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Mencari apa?',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            style: BorderStyle.none,
          )
        ),
        filled: true,
        fillColor: Colors.white
      ),
    );

    List<String> totalBerat = Keranjang.totalBerat(listKeranjang);
    List<String> totalHarga = Keranjang.totalHarga(listKeranjang);

    return Scaffold(
      appBar: AppBar(
        title: listKeranjangDipilih.length == 0 ? Text(
          'Keranjang',
        ) : Text(
          '${listKeranjangDipilih.length} Dipilih',
          style: TextStyle(color: Colors.black),
        ),
        actions: listKeranjangDipilih.length == 0 ? <Widget>[] : <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.black,
            onPressed: (){

            }
          )
        ],
        backgroundColor: listKeranjangDipilih.length == 0 ? null : Colors.white,
        iconTheme: IconThemeData(
          color: listKeranjangDipilih.length == 0 ? Colors.white : Colors.black
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: ScrollController(),
              itemCount: listKeranjang.length,
              itemBuilder: (context, indeks){
                return ListKeranjang(indeks: indeks, keranjangPageState: this);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.grey[100],
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(totalHarga[0]),
                    ),
                    Expanded(
                      child: Text(
                        totalHarga[1],
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      )
                    )
                  ]
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(totalBerat[0]),
                    ),
                    Expanded(
                      child: Text(
                        totalBerat[1],
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      )
                    )
                  ]
                )
              ],
            )
          )
        ]
      )
    );
  }
}

class ListKeranjang extends StatefulWidget
{
  ListKeranjang({Key key, this.indeks, this.keranjangPageState}) : super(key: key);

  final int indeks;
  final _KeranjangPageState keranjangPageState;

  @override
  _ListKeranjangPageState createState() => _ListKeranjangPageState();
}

class _ListKeranjangPageState extends State<ListKeranjang>
{
  void modifikasiPilihan()
  {
    if(!listKeranjang[widget.indeks].dicentang)
    {
      listKeranjang[widget.indeks].dicentang = true;
      widget.keranjangPageState.listKeranjangDipilih.add(listKeranjang[widget.indeks]);
      //print('Banyak list keranjang: ${widget.keranjangPageState.listKeranjangDipilih.length}');
    }
    else
    {
      widget.keranjangPageState.listKeranjangDipilih.remove(listKeranjang[widget.indeks]);
      listKeranjang[widget.indeks].dicentang = false;
      //print('Banyak list keranjang: ${widget.keranjangPageState.listKeranjangDipilih.length}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.keranjangPageState.setState((){
          if(widget.keranjangPageState.dalamPemilihan)
          {
            modifikasiPilihan();
            if(widget.keranjangPageState.listKeranjangDipilih.length == 0)
              widget.keranjangPageState.dalamPemilihan = false;
          }
        });
      },
      onLongPress: (){
        widget.keranjangPageState.setState((){
          if(!widget.keranjangPageState.dalamPemilihan)
          {
            modifikasiPilihan();
            widget.keranjangPageState.dalamPemilihan = true;
          }
        });
      },
      child: Container(
        color: listKeranjang[widget.indeks].dicentang ? Colors.grey[100] : null,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          padding: EdgeInsets.only(top: 16.0, bottom: 15.0),
          decoration: BoxDecoration(
            border: Border(
              top: widget.indeks == 0 ? BorderSide.none : BorderSide(
                color: Colors.grey,
              )
            )
          ),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      listKeranjang[widget.indeks].gambar != null ? Container(
                        width: 75.0,
                        height: 75.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          image: DecorationImage(
                            image: MemoryImage(listKeranjang[widget.indeks].gambar),
                            fit: BoxFit.cover,
                          )
                        ),
                      ) : Placeholder(
                        fallbackWidth: 75.0,
                        fallbackHeight: 75.0
                      ),
                      listKeranjang[widget.indeks].dicentang ? Positioned(
                        child: Icon(
                          Icons.check_circle
                        ),
                        right: 2.0,
                        bottom: 2.0,
                      ) : Container()
                    ]
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          listKeranjang[widget.indeks].nama,
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          'Rp. ${listKeranjang[widget.indeks].harga}',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          '${listKeranjang[widget.indeks].berat} kg',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ]
                    ),
                  )
                ]
              ),
              SizedBox(height: 13.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    color: Colors.amber,
                    child: Text(
                      'Ubah',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onPressed: (){

                    },
                  ),
                  SizedBox(width: 10.0),
                  FlatButton(
                    color: Colors.red,
                    child: Text(
                      'Hapus',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onPressed: (){

                    },
                  )
                ],
              )
            ]
          )
        )
      )
    );
  }
}