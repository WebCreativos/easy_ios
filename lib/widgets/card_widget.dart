import 'package:flutter/material.dart';


class CardWidget extends StatelessWidget {
  final Map data;
  CardWidget({
    Key key,
    @required this.data
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width * 0.75;
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        alignment: Alignment.bottomLeft,
        height:200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),

          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.srcOver),
            image: NetworkImage(
              (data['imgPath'] != null) ? data['imgPath'].toString() :
              'https://palomasala.com/wp-content/uploads/2018/12/dieta-de-5-comidas-al-dia-para-la-perdida-de-peso-o-adelgazamiento-mito-o-realidad.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
              width: size.width,
              decoration: BoxDecoration(
                border:Border(top: BorderSide(color: Colors.white, width: 1))
              ),
              padding: EdgeInsets.only(left: 20, bottom: 10.0,top:10),
              child: Text(
                data['nombre'].toString().toUpperCase(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ),
      ),
    );
  }
}