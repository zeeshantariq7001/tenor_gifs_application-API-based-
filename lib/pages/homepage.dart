import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:marquee/marquee.dart';
import 'package:tenor_gifs/A-P-I/api_manager.dart';
import 'package:tenor_gifs/models/tenor_moddel.dart';
import 'package:tenor_gifs/pages/Gif_Preview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    buildSearch();
    super.dispose();
  }

  List<Result> post = [];
  TextEditingController controlC = TextEditingController();
  Future<ApIjson> _gifmodel;
  GifController controller;

  @override
  void initState() {
    _gifmodel = ApiManager.getGifs(controlC.text);
    controller = GifController(vsync: this);
    // getme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              height: 160,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Image.network(
                            "https://i.pinimg.com/originals/df/ea/dd/dfeaddf703acf71277dbb1d6d81479b0.gif"),
                        SizedBox(
                          width: 70,
                        ),
                        Text("Welcome to"),
                        Text(
                          "Tenor Gifs",
                          style: TextStyle(color: Colors.purple),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                    width: double.infinity,
                    child: buildSearch(),
                  ),
                ],
              ),
            ),
            Container(
              height: 70,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Marquee(
                  text: 'Share your favourite Gifs',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 100.0,
                  pauseAfterRound: Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                  )),
            ),
            Expanded(
              child: Scrollbar(
                showTrackOnHover: true,
                isAlwaysShown: true,
                hoverThickness: 20,
                thickness: 10,
                interactive: true,
                child: FutureBuilder<ApIjson>(
                  future: _gifmodel,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controlC,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(35)),
            hintText: "Search Gif...",
            hintStyle: TextStyle(color: Colors.blue),
            labelText: "Search Gif...",
            labelStyle: TextStyle(color: Colors.blue),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.purple,
            ),
            fillColor: Colors.grey.withOpacity(0.1),
            filled: true,
          ),
          onSubmitted: (va) {
            setState(() {
              controlC.text = va;
              _gifmodel = ApiManager.getGifs(controlC.text);

              print(controlC.text);
            });
          },
        ),
      ),
    );
  }
}
