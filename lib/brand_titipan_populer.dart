import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masterbagasi/api_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:transparent_image/transparent_image.dart';

class BrandTitipanPopulerPage extends StatefulWidget {
  BrandTitipanPopulerPage({Key key}) : super(key: key);

  static String route = 'utama/brand-titipan-populer';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _BrandTitipanPopulerPageState createState() => _BrandTitipanPopulerPageState();
}

class _BrandTitipanPopulerPageState extends State<BrandTitipanPopulerPage> {

  ApiService _apiService;
  List<SampelFoto> daftarSampelFoto;
  Future<List<SampelFoto>> _futureBrandTitipanPopuler;

  TextEditingController _controllerCari;
  FocusNode _focusNodeCari;
  int status;

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool loadingBertahap;
  ScrollController _scrollController;

  void _cekPencarian(String cari)
  {

  }

  Widget _sampelItemTitipanSaya(SampelFoto sampelFoto)
  {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: sampelFoto.thumbnailUrl,
              width: 150.0
            ),
            SizedBox(height: 10.0),
            Text('Sampel Foto', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4.0),
            Text('Deskripsi')
          ],
        )
      ),
      onTap:(){
        //Navigator.of(context).pushNamed(DetailBarangPage.route, arguments: satuData['id']);
      }
    );
  }

  void _onRefresh() async
  {
    await Future.delayed(Duration(seconds: 3));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async
  {
    await Future.delayed(Duration(seconds: 3));
    _refreshController.loadComplete();
  }

  Widget _gridViewBrandTitipan(List<SampelFoto> snapshotDaftarSampelFoto, Orientation orientation, {bool loading = false})
  {
    return SmartRefresher(
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      enablePullDown: true,
      controller: _refreshController,
      header: ClassicHeader(
        completeText: 'Refresh selesai.',
        refreshingText: 'Sedang melakukan refresh.',
        failedText: 'Refresh gagal.',
        releaseText: 'Lepas untuk refresh.',
        idleText: 'Turunkan untuk refresh.',
      ),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index){
                return _sampelItemTitipanSaya(snapshotDaftarSampelFoto[index]);
              },
              childCount: snapshotDaftarSampelFoto.length
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
              childAspectRatio: 100.0 / 129.0,
            )
          ),
          SliverToBoxAdapter(
            child: loading ? SizedBox(
              height: 70.0,
              child: Center(
                child: CircularProgressIndicator()
              )
            ) : SizedBox()
          ),
        ],
      )
    );
  }

  Widget _isiTitipanSaya()
  {
    Orientation orientation = MediaQuery.of(context).orientation;
    return FutureBuilder(
      future: _futureBrandTitipanPopuler,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done)
        {
          List<SampelFoto> snapshotDaftarSampelFoto = snapshot.data;
          if(!snapshot.hasError)
          {
            if(snapshotDaftarSampelFoto.length > 0)
              return _gridViewBrandTitipan(snapshotDaftarSampelFoto, orientation);
          }
          else
          {
            return Center(
              child: Text('Tidak ada data.')
            );
          }
        }
        else if(snapshot.connectionState == ConnectionState.waiting)
        {
          if(daftarSampelFoto.length > 0)
            return _gridViewBrandTitipan(daftarSampelFoto, orientation, loading: true);
          else
          {
            return Center(
              child: CircularProgressIndicator()
            );
          }
        }
      }
    );
  }

  void _onScroll()
  {
    if(_scrollController.position.maxScrollExtent - _scrollController.offset <= 200.0)
    {
      if(!loadingBertahap)
      {
        setState((){
          loadingBertahap = true;
          _futureBrandTitipanPopuler = dapatkanSampelBertahap(inisialisasiUlang: false);
        });

        print('Halo');
      }
    }
  }

  @override
  void initState()
  {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    daftarSampelFoto = List<SampelFoto>();
    _focusNodeCari = FocusNode();
    _apiService = ApiService();
    _futureBrandTitipanPopuler = dapatkanSampelBertahap();
    loadingBertahap = false;
    status = 1;
  }

  Future<List<SampelFoto>> dapatkanSampelBertahap({bool inisialisasiUlang = true}) async
  {
    if(inisialisasiUlang)
      daftarSampelFoto.clear();

    daftarSampelFoto.addAll(await _apiService.dapatkanSampel());

    if(!inisialisasiUlang && loadingBertahap)
      loadingBertahap = false;

    return daftarSampelFoto;
  }

  @override
  void dispose()
  {
    _focusNodeCari.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    //Tentukan apakah ada tombol search atau tidak.
    Widget teksCari = TextField(
      focusNode: _focusNodeCari,
      controller: _controllerCari,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Mau mencari apa?',
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
        alignLabelWithHint: true,
        border: InputBorder.none,
        hoverColor: Colors.grey[400],
      ),
      onChanged: _cekPencarian,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.grey[600],
    );

    //Cek jika terjadi perubahan status
    //Status 1: dalam kondisi biasa
    //Status 2: dalam kondisi mencari
    if(status == 2)
      FocusScope.of(context).requestFocus(_focusNodeCari);
    else
      _focusNodeCari.unfocus();

    Widget teksJudul = Text('Brand Titipan Populer');

    return WillPopScope(
      onWillPop: () async {
        if(status == 2)
        {
          setState((){
            status = 1;
          });

          return false;
        }
        else
          return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: status == 1 ? Theme.of(context).appBarTheme.color : Colors.white,
          iconTheme: IconThemeData(color: status == 2 ? Colors.grey[600] : Colors.white),
          title: status == 1 ? teksJudul : teksCari,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                setState((){
                  status = 2;
                });
              }
            )
          ],
        ),
        body: _isiTitipanSaya()
      )
    );
  }
}
