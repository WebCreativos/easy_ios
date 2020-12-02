import 'package:flutter/material.dart';

class tipoDeFigura extends StatelessWidget{

  final IconData icon;
  final String description;
  final bool selected;
  final VoidCallback callback;

  tipoDeFigura({
    Key key,
    this.icon,
    this.description,
    this.selected = false,
    this.callback
  });

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: InkWell(
        onTap: this.callback,
        child: Container(
          color: (selected) ? Color(0xff5937B2) : Color(0xff260D6C),
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.08,
            right: MediaQuery.of(context).size.width * 0.08,
          ),
          child: Row(
            children: <Widget>[
              Icon(icon,color: Colors.orangeAccent,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                  child: Text(description,style: TextStyle(
                      color: Colors.white
                  ),
              ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}