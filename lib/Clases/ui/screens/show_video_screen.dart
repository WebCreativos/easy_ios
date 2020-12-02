import 'package:flutter/material.dart';
import 'package:easygymclub/Clases/model/clases_model.dart';
import 'package:better_player/better_player.dart';
  
class ShowVideoScreen extends StatefulWidget {
  ClasesModel clase;
  ShowVideoScreen({Key key,this.clase});
  @override 
  _ShowVideoScreenState createState() => _ShowVideoScreenState();
}

class _ShowVideoScreenState extends State<ShowVideoScreen> {
  BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.NETWORK, widget.clase.video); 

    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return  Scaffold(
        backgroundColor: Color(0xff260d6c),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff3F1D9D),
          title: Text(widget.clase.titulo),
        ),
        body: Container( 
          height: MediaQuery.of(context).size.height,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                 child: BetterPlayer(
                  controller: _betterPlayerController,
                ),
              ),
                SizedBox(height:10),
                Divider(height:1,color:Colors.white),
                Padding(
                  padding: EdgeInsets.all(15),
                  child:Text(  
                    widget.clase.titulo.toString(),
                    style: TextStyle(color:Colors.white,fontSize: 22,fontWeight: FontWeight.w500),textAlign: TextAlign.left,
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child:Text(
                    widget.clase.descripcion.toString(),
                    style: TextStyle(color:Colors.white,fontSize: 16,fontWeight: FontWeight.w300),textAlign: TextAlign.left,
                  )
                )

            ],
          ) ,
        ),
      );
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }
}
