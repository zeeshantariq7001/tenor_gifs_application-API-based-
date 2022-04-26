import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class GifPreview extends StatelessWidget {
  String finalresult;
  GifPreview({this.finalresult});

  ScreenshotController screenC = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.7),
        title: Text("Gif Preview"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Screenshot(
              controller: screenC,
              child: Container(
                height: 200,
                width: 200,
                child: Image.network(finalresult),
              ),
            ),
            IconButton(
                onPressed: () async {
                  final urlGif = finalresult;
                  final url = Uri.parse(urlGif);
                  final response = await http.get(url);
                  final bytes = response.bodyBytes;
                  final temp = await getTemporaryDirectory();
                  final gifPath = "${temp.path}/tenor.gif";
                  File(gifPath).writeAsBytesSync(bytes);
                  Share.shareFiles([gifPath]);
                },
                icon: Icon(Icons.share)),
          ],
        ),
      ),
    );
  }
}
