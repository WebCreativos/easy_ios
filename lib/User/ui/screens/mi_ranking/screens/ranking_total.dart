import 'package:flutter/material.dart';

class RankingTotal extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _RankingTotal();
  }

}

class _RankingTotal extends State<RankingTotal>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3F1D9D),
        title: Text("Ranking Total"),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, color:Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder(
        future: Future.value(1),
        builder: (context,snap){

          if(!snap.hasData || snap.hasError ){

            return Container(
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
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.orangeAccent
                  ),
                ),
              ),
            );
          }else{

            return _body(snap);
          }

          return null;
        },
      ),
    );
  }

  Widget _body(AsyncSnapshot snap){

    //List<Meta>

    return Container(
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
      child: Text("Loaded!")
    );
  }

}