import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:masterbagasi/api_service.dart';
import 'package:masterbagasi/brand_titipan_populer.dart';
import 'package:masterbagasi/detail_barang/detail_barang.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:transparent_image/transparent_image.dart';

class Beranda extends StatefulWidget {
  Beranda({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda>
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

  Widget _cardKategori()
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
                Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Kategori dari tiap produk.'),
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

  Widget _cardPesananSiapBerangkat()
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
                Text('Daftar Pesanan', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Pesanan berupa titipan yang sudah dilakukan.'),
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

  Widget _cardTitipanTerbaru()
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
                Text('Titipan Terbaru', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Inilah titipan terbaru yang baru saja.'),
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
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: AspectRatio(
              aspectRatio: 1920.0 / 1080.0,
              child: Container(
                width: double.infinity,
                color: Colors.blue,
                child: PageView(
                  children: <Widget>[
                    sampelGambar(),
                    sampelGambar(),
                    sampelGambar()
                  ],
                )
              )
            )
          ),
          SliverToBoxAdapter(
            child: _cardPesananSiapBerangkat()
          )
          /*_cardKategori(),
          _cardBrandTitipanPopuler(),
          _cardTitipanTerbaru(),*/
        ],
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Widget sampelGambar()
  {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Gambar 1',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Perbandingannya adalah 1920 : 1080.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          )
        ]
      )
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