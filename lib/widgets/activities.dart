import 'package:flutter/material.dart';

class Activities extends StatelessWidget {

  final Color startColorBackground;
  final Color endColorBackground;
  final IconData icon;
  final String title;
  //final String description

  Activities({
    Key key,
    this.startColorBackground,
    this.endColorBackground,
    this.icon,
    this.title
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      //height: MediaQuery.of(context).size.height * 0.23,
      width: MediaQuery.of(context).size.width,
      height: (MediaQuery.of(context).size.height*0.3),
      margin: EdgeInsets.only(
        top: 10.0,
        bottom: 5.0
      ),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            this.startColorBackground,
            this.endColorBackground
          ]
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
                ),
                child: Icon(this.icon,
                  size: 55.0,
                  color: this.endColorBackground,
                ),
              ),
              InkWell(
                child: Icon(Icons.keyboard_arrow_right,
                  size: 35.0,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => _activitieDescription(context))
                  );
                },
              )
            ],
          ),
          Text(this.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold
          ),),
          Text("Breve explicación de la actividad.",
          style: TextStyle(
            color:Colors.white
          ),)
        ],
      ),
    );
  }

  Widget _activitieDescription(context){
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                this.startColorBackground,
                this.endColorBackground
              ]
          )
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height * 0.03,
              left: MediaQuery.of(context).size.width * 0.01,
              child: InkWell(
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 50.0,
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
            Center(
              child:Text("Ut non enim eleifend felis pretium feugiat. \n Vestibulum purus quam, scelerisque ut, mollis sed, nonummy id, metus.",
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}