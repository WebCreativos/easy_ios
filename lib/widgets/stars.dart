import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Stars extends StatefulWidget {
  final int initValue;
  final Function(int) onCountChange;
  Stars({
    this.onCountChange,
    this.initValue
  });
  @override
  _StarsState createState() => _StarsState();
}

class _StarsState extends State < Stars > {
  int value;
  void initState() {
    this.value = widget.initValue;
    super.initState();
  }
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return
        InkWell(
          onTap: () {
            setState(() {
              value = index + 1;
              widget.onCountChange(value);
            });
          },
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: (index < value) ? FaIcon(
              FontAwesomeIcons.bolt,
              color: Colors.black,
            ) : FaIcon(
              FontAwesomeIcons.bolt,
              color: Colors.black26,
            ),
          ),
        );
      }),
    );
  }
}
class FixedStars extends StatelessWidget {
  final int value;
  FixedStars({
    Key key,
    this.value
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return
        Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: (index < value) ? FaIcon(
              FontAwesomeIcons.bolt,
              color: Colors.white,
            ) : FaIcon(
              FontAwesomeIcons.bolt,
              color: Colors.white30,
            ),
        );
      }),
    );
  }
}