import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SummonerInfoDisplayCard extends StatelessWidget {
  SummonerInfoDisplayCard({
    @required this.imageAsset,
    @required this.columnChildren,
    this.imageHeight=128,
    this.imageWidth=128,
  });

  final String imageAsset;
  final List<Widget> columnChildren;
  final double imageWidth;
  final double imageHeight;

  List<Widget> _widgetList(){
    return this.columnChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: new BorderSide(
          color: Colors.black,
          width: 0.7,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: Platform.isWindows || kIsWeb?350:null,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 128,
                child: Center(
                  child: Image.asset(
                    '$imageAsset',
                    height: this.imageHeight,
                    width: this.imageWidth,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _widgetList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
