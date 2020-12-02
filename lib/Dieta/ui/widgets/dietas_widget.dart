import 'package:flutter/material.dart';
import 'package:easygymclub/Dieta/model/dieta_model.dart';

class DietasWidget extends StatelessWidget {
  final VoidCallback callbackOnPressed;

  DietaModel dieta;

  DietasWidget({
    Key key,
    @required this.callbackOnPressed,
    this.dieta
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.callbackOnPressed,
      child: Container(
        margin:
        EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.03),
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
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
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x0000004a),
              spreadRadius: 1.0,
              blurRadius: 5.0,
              offset: Offset(5.0, 10.0))
          ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: < Widget > [
            Container(
              padding: EdgeInsets.all(0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                  image: DecorationImage(image: NetworkImage((dieta.imgPath != null) ? dieta.imgPath : 'https://palomasala.com/wp-content/uploads/2018/12/dieta-de-5-comidas-al-dia-para-la-perdida-de-peso-o-adelgazamiento-mito-o-realidad.jpg', ), fit: BoxFit.cover, )),
                alignment: Alignment.centerLeft,
                height: 100,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:15),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 5),
              child: Column(
                children: < Widget > [
                  Text(
                    this.dieta.nombre,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                  ),

                ],
              ))
          ],
        ),
      ));
  }
}