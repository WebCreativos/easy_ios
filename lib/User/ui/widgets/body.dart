import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Widget body;

  Body({
    Key key,
    this.body

  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3F1D9D),
        title: Text("Metas alcanzadas"),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, color:Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff04E0BA),
              Color(0xff0283DA)
            ]
          )
        ),
        child: FutureBuilder(
          future: Future.value(1),
          builder: (context,snap){

            if(!snap.hasData || snap.hasError){
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                ),
              );
            }else{

              switch(snap.connectionState){

                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  return CircularProgressIndicator();//_body(snap);
                  break;
              }
            }
            return null;
          },
        ),
      ),
    );
  }
}