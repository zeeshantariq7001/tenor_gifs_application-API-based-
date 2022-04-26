import 'package:flutter/material.dart';
import 'package:tenor_gifs/A-P-I/api_manager.dart';
import 'package:tenor_gifs/models/tenor_moddel.dart';
import 'package:tenor_gifs/pages/Gif_Preview.dart';

class HappyGif extends StatefulWidget {
  @override
  _HappyGifState createState() => _HappyGifState();
}

class _HappyGifState extends State<HappyGif> {
  Future<ApIjson> _gifmodel;
  @override
  void initState() {
    _gifmodel = ApiManager.getGifs("happy");
    // getme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Happy Gifs"),
      ),
      body: FutureBuilder<ApIjson>(
        future: _gifmodel,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: snapshot.data.results.length,
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
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      child: Image.network(
                                        finalresult,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                  );
                });
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
