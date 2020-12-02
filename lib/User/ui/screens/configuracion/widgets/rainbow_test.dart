import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScoreMeter extends StatelessWidget {
  final double score;

  ScoreMeter({this.score, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ScoreMeterItem(
                score: score,
                color: Colors.blueAccent,
                minRange: 0,
                maxRange: 18.5),
          ),
          Expanded(
            child: ScoreMeterItem(
                score: score,
                color: Colors.greenAccent,
                minRange: 18.5,
                maxRange: 25.0),
          ),
          Expanded(
            child: ScoreMeterItem(
                score: score,
                color: Colors.yellowAccent,
                minRange: 25.0,
                maxRange: 28.0),
          ),
          Expanded(
            child: ScoreMeterItem(
                score: score,
                color: Colors.orangeAccent,
                minRange: 28.0,
                maxRange: 32.0),
          ),
          Expanded(
            child: ScoreMeterItem(
                score: score,
                color: Colors.redAccent,
                minRange: 32.0,
                maxRange: 60.0),
          ),
        ],
      ),
    );
  }
}

class ScoreMeterItem extends StatelessWidget {
  /// Hello World
  final double score;
  final Color color;
  final double minRange;
  final double maxRange;

  ScoreMeterItem(
      {this.score,
      this.color = Colors.grey,
      @required this.minRange,
      @required this.maxRange,
      Key key})
      : assert(minRange != null),
        assert(maxRange != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: Column(
        children: <Widget>[
          score >= minRange && score <= maxRange
              ? SizedBox(
                  height: 10.0,
                  child: Align(
                    alignment: Alignment(
                        (score - minRange) / (maxRange - minRange) * 2 - 1,
                        0.0),
                    child: Arrow(color: color),
                  ),
                )
              : SizedBox(
                  height: 10.0,
                ),
          ScoreMeterBar(color: color),
          Padding(
            padding: EdgeInsets.only(left: 3.0),
            child: Text(maxRange.toString(),
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.white, fontSize: 10)),
          ),
        ],
      ),
    );
  }
}

class Arrow extends StatelessWidget {
  final Color color;

  Arrow({this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.0,
      width: 10.0,
      child: ClipRect(
        child: OverflowBox(
          maxWidth: 10.0,
          maxHeight: 10.0,
          child: Align(
            alignment: Alignment.topCenter,
            child: Transform.translate(
              offset: Offset(.0, -5.0),
              child: Transform.rotate(
                angle: pi / 4,
                child: Container(
                  width: 10.0,
                  height: 10.0,
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScoreMeterBar extends StatelessWidget {
  final Color color;

  ScoreMeterBar({this.color = Colors.grey, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.0,
      decoration: BoxDecoration(
        borderRadius: _getBorderRadius(),
        color: color,
      ),
    );
  }

  BorderRadius _getBorderRadius() {
    if (this.color == Colors.blueAccent) {
      return BorderRadius.only(
          bottomLeft: Radius.circular(4.0), topLeft: Radius.circular(4.0));
    } else if (this.color == Colors.redAccent) {
      return BorderRadius.only(
          bottomRight: Radius.circular(4.0), topRight: Radius.circular(4.0));
    }

    return null;
  }
}
