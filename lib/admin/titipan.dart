import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:masterbagasi/api_service.dart';
import 'package:masterbagasi/brand_titipan_populer.dart';
import 'package:masterbagasi/detail_barang/detail_barang.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:transparent_image/transparent_image.dart';

class Titipan extends StatefulWidget {
  Titipan({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _TitipanState createState() => _TitipanState();
}

class _TitipanState extends State<Titipan>
{
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  ScrollController _scrollController = ScrollController();
  Future<List<SampelFoto>> _futureBarangPopuler;

  @override
  void initState()
  {
    super.initState();
    _futureBarangPopuler = ApiService().dapatkanSampel();
  }

  @override
  void dispose()
  {
    super.dispose();
  }

  Widget _cardBrandTitipanPopuler()
  {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Brand Titipan Populer', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Inilah titipan yang saat ini sedang populer.'),
              ],
            )
          ),
          SizedBox(
            child: FutureBuilder(
              future: _futureBarangPopuler,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done)
                {
                  if(!snapshot.hasError)
                  {
                    List<SampelFoto> hasil = snapshot.data;

                    List<Widget> kolom = <Widget>[
                      SizedBox(
                        //color: Colors.black,
                        height: 200.0,
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            return _buatSampelItem(hasil[index]);
                          },

                          itemCount: hasil.length,
                          scrollDirection: Axis.horizontal,
                          itemExtent: 130.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                        child: FlatButton(
                          child: Text(
                            'Lihat Selengkapnya',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: (){
                            Navigator.of(context).pushNamed(BrandTitipanPopulerPage.route);
                          },
                        )
                      )
                    ];
                    return Column(
                      children: kolom,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    );
                  }
                  else
                  {
                    DioError error = snapshot.error;
                    return SizedBox(
                      height: 200.0,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.error, size: 50.0),
                            SizedBox(height: 10.0),
                            Text(
                              'Ada Masalah Dengan Pengambilan Data',
                              style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                            Text(
                              error.message,
                            ),
                          ]
                        )
                      )
                    );
                  }
                }
                else if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return SizedBox(
                    height: 200.0,
                    child: Center(
                      child: CircularProgressIndicator()
                    )
                  );
                }
              }
            )
          )
        ]
      )
    );
  }

  Widget _cardPenitip()
  {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Penitip', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Penitip yang paling atas.'),
              ],
            )
          ),
          SizedBox(
            child: FutureBuilder(
              future: _futureBarangPopuler,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done)
                {
                  if(!snapshot.hasError)
                  {
                    List<SampelFoto> hasil = snapshot.data;

                    List<Widget> kolom = <Widget>[
                      SizedBox(
                        //color: Colors.black,
                        height: 200.0,
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            return _buatSampelItem(hasil[index]);
                          },

                          itemCount: hasil.length,
                          scrollDirection: Axis.horizontal,
                          itemExtent: 130.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                        child: FlatButton(
                          child: Text(
                            'Lihat Selengkapnya',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: (){
                            Navigator.of(context).pushNamed(BrandTitipanPopulerPage.route);
                          },
                        )
                      )
                    ];
                    return Column(
                      children: kolom,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    );
                  }
                  else
                  {
                    DioError error = snapshot.error;
                    return SizedBox(
                      height: 200.0,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.error, size: 50.0),
                            SizedBox(height: 10.0),
                            Text(
                              'Ada Masalah Dengan Pengambilan Data',
                              style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                            Text(
                              error.message,
                            ),
                          ]
                        )
                      )
                    );
                  }
                }
                else if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return SizedBox(
                    height: 200.0,
                    child: Center(
                      child: CircularProgressIndicator()
                    )
                  );
                }
              }
            )
          )
        ]
      )
    );
  }

  Widget _cardBarang()
  {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Barang', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Daftar barang yang banyak dibeli.'),
              ],
            )
          ),
          SizedBox(
            child: FutureBuilder(
              future: _futureBarangPopuler,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done)
                {
                  if(!snapshot.hasError)
                  {
                    List<SampelFoto> hasil = snapshot.data;

                    List<Widget> kolom = <Widget>[
                      SizedBox(
                        //color: Colors.black,
                        height: 200.0,
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            return _buatSampelItem(hasil[index]);
                          },

                          itemCount: hasil.length,
                          scrollDirection: Axis.horizontal,
                          itemExtent: 130.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                        child: FlatButton(
                          child: Text(
                            'Lihat Selengkapnya',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: (){
                            Navigator.of(context).pushNamed(BrandTitipanPopulerPage.route);
                          },
                        )
                      )
                    ];
                    return Column(
                      children: kolom,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    );
                  }
                  else
                  {
                    DioError error = snapshot.error;
                    return SizedBox(
                      height: 200.0,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.error, size: 50.0),
                            SizedBox(height: 10.0),
                            Text(
                              'Ada Masalah Dengan Pengambilan Data',
                              style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                            Text(
                              error.message,
                            ),
                          ]
                        )
                      )
                    );
                  }
                }
                else if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return SizedBox(
                    height: 200.0,
                    child: Center(
                      child: CircularProgressIndicator()
                    )
                  );
                }
              }
            )
          )
        ]
      )
    );
  }

  Widget _cardTitipan()
  {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Titipan', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Daftar titipan saat ini.'),
              ],
            )
          ),
          SizedBox(
            child: FutureBuilder(
              future: _futureBarangPopuler,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done)
                {
                  if(!snapshot.hasError)
                  {
                    List<SampelFoto> hasil = snapshot.data;

                    List<Widget> kolom = <Widget>[
                      SizedBox(
                        //color: Colors.black,
                        height: 200.0,
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            return _buatSampelItem(hasil[index]);
                          },

                          itemCount: hasil.length,
                          scrollDirection: Axis.horizontal,
                          itemExtent: 130.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                        child: FlatButton(
                          child: Text(
                            'Lihat Selengkapnya',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: (){
                            Navigator.of(context).pushNamed(BrandTitipanPopulerPage.route);
                          },
                        )
                      )
                    ];
                    return Column(
                      children: kolom,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    );
                  }
                  else
                  {
                    DioError error = snapshot.error;
                    return SizedBox(
                      height: 200.0,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.error, size: 50.0),
                            SizedBox(height: 10.0),
                            Text(
                              'Ada Masalah Dengan Pengambilan Data',
                              style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                            Text(
                              error.message,
                            ),
                          ]
                        )
                      )
                    );
                  }
                }
                else if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return SizedBox(
                    height: 200.0,
                    child: Center(
                      child: CircularProgressIndicator()
                    )
                  );
                }
              }
            )
          )
        ]
      )
    );
  }

  Widget _buatSampelItem(SampelFoto satuData, {String sampelTitle = 'Sampel', String sampelDeskripsi = 'Deskripsi Sampel'})
  {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: satuData.thumbnailUrl,
              width: 150.0
            ),
            SizedBox(height: 7.0),
            Text(sampelTitle, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4.0),
            Text(sampelDeskripsi),
            SizedBox(height: 4.0),
            Text('X X X X X (500)')
          ],
        )
      ),
      onTap:(){
        print('Id: ${satuData.id}');
        Navigator.of(context).pushNamed(DetailBarangPage.route, arguments: satuData.id);
      }
    );
  }

  Widget _buatTimelineTanggal(SampelFoto satuData, {String sampelTitle = 'Sampel', String sampelDeskripsi = 'Deskripsi Sampel'})
  {
    return InkWell(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(sampelTitle, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4.0),
              Text(sampelDeskripsi)
            ],
          )
        )
      ),
      onTap:(){
        print('Id: ${satuData.id}');
        Navigator.of(context).pushNamed(DetailBarangPage.route, arguments: satuData.id);
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      onRefresh: _onRefresh,
      enablePullDown: true,
      enablePullUp: false,
      controller: _refreshController,
      child: ListView(
        controller: _scrollController,
        children: <Widget>[
          _cardPenitip(),
          _cardTitipan(),
          _cardBarang(),
        ],
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Future<void> _onRefresh() async {
    setState((){
      _futureBarangPopuler = ApiService().dapatkanSampel();
    });

    _refreshController.refreshCompleted();
    print('Refresh beranda.');
  }
}