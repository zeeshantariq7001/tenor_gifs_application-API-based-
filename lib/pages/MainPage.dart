import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:tenor_gifs/A-P-I/api_manager.dart';
import 'package:tenor_gifs/models/tenor_moddel.dart';
import 'package:tenor_gifs/pages/Gif_Preview.dart';
import 'package:tenor_gifs/pages/happy.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<HappyGif> gifs = [];
  Future<ApIjson> _gifmodel;
  GifController controller;
  TextEditingController controlC = TextEditingController();

  @override
  void initState() {
    _gifmodel = ApiManager.getGifs(controlC.text);
    // getme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tenor"),
      ),
      body: FutureBuilder<ApIjson>(
        future: _gifmodel,
        builder: (BuildContext context, snapshot) {
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              // itemCount: snapshot.data.results.length,
              itemCount: 4,
              itemBuilder: (context, index) {
                var result = snapshot.data.results[index].media
                    .map((e) => e['gif'].url.toString())
                    .toList();
                var finalresult = result[0];
                print("$result");

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: result.isEmpty
                      ? Text("no data")
                      : SingleChildScrollView(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (v) {
                                return GifPreview(
                                  finalresult: finalresult,
                                );
                              }));
                            },
                            child: InkWell(
                              onTap: () {
                                _gifmodel = ApiManager.getGifs('happy');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (c) {
                                    return HappyGif();
                                  }),
                                );
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border:
                                              Border.all(color: Colors.purple)),
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.face),
                                          // Image.network(
                                          //   "https://i.pinimg.com/originals/3d/e0/6f/3de06f0cf51930687b1685b81894485a.png",
                                          //   height: 50,
                                          //   width: 50,
                                          //   fit: BoxFit.contain,
                                          // ),
                                          Text("Happy"),
                                        ],
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                );
              });
        },
      ),
    );
  }
}
