import 'package:flutter/material.dart';
class Ejercicio extends StatelessWidget {
  Map rutina;

  Ejercicio({
    Key key,
    @required this.rutina,
  });
  @override
  Widget build(BuildContext context) {
    return
    Flexible(
      child: ListView(
        children: < Widget > [
          for (var i=0;i<this.rutina["series"];i++)

          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF3f1d9d),
                    Color(0xFF5937b2)
                  ], // whitish to gray
                  tileMode:
                  TileMode.mirror, // repeats the gradient over the canvas
                ),
                borderRadius: BorderRadius.circular(5),
                color: Color(
                  0xff260d6c),
                boxShadow: [BoxShadow(
                  color: Colors.black54,
                  blurRadius: 20.0,
                )]
              ),
              child: ListTile(
                trailing: InkWell(
                  onTap: () {
                    print("A hacer excercise baby... vamo' ");
                  },
                ),
                title: Text(rutina["nombre"].toString() + this.rutina["series"].toString(),
                  style: TextStyle(color: Colors.white), ),
              ),
            )
          )

        ],
      )
    );
  }
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: < Widget > [
              new ListTile(
                leading: new Icon(Icons.music_note),
                title: new Text('Music'),
                onTap: () => {}
              ),
              new ListTile(
                leading: new Icon(Icons.videocam),
                title: new Text('Video'),
                onTap: () => {},
              ),
            ],
          ),
        );
      }
    );
  }
}