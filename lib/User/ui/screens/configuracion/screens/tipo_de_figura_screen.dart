import 'package:easygymclub/User/ui/screens/configuracion/widgets/tipo_de_figura.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


enum selected_figure {
  RELOJ_DE_ARENA,
  TRIANGULO,
  TRIANGULO_INVERTIDO,
  RECTANGULO,
  ELIPSE
}

class tipoDeFiguraScreen extends StatelessWidget{

  selected_figure select_figure;

  tipoDeFiguraScreen(
  {
    Key key,
    this.select_figure
  }
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.white,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Tipo de figura",style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Color(0xff3F1D9D),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            tipoDeFigura(
              callback: () {
                this.select_figure = selected_figure.RELOJ_DE_ARENA;
                Navigator.of(context).pop(selected_figure.RELOJ_DE_ARENA);
              },
              selected: (select_figure == selected_figure.RELOJ_DE_ARENA) ? true : false,
              icon: Icons.trip_origin,
              description: "Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Fusce fermentum. Vestibulum turpis sem, aliquet eget, lobortis pellentesque, rutrum eu, nisl.",),
            tipoDeFigura(
              callback: () {
                this.select_figure = selected_figure.TRIANGULO;
                Navigator.of(context).pop(selected_figure.TRIANGULO);
              },
              selected: (select_figure == selected_figure.TRIANGULO) ? true : false,
              icon: Icons.trip_origin,
              description: "Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Fusce fermentum. Vestibulum turpis sem, aliquet eget, lobortis pellentesque, rutrum eu, nisl.",),
            tipoDeFigura(
              callback: () {
                this.select_figure = selected_figure.TRIANGULO_INVERTIDO;
                Navigator.of(context).pop(selected_figure.TRIANGULO_INVERTIDO);
              },
              selected: (select_figure == selected_figure.TRIANGULO_INVERTIDO) ? true : false,
              icon: Icons.trip_origin,
              description: "Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Fusce fermentum. Vestibulum turpis sem, aliquet eget, lobortis pellentesque, rutrum eu, nisl.",),
            tipoDeFigura(
              callback: () {
                this.select_figure = selected_figure.RECTANGULO;
                Navigator.of(context).pop(selected_figure.RECTANGULO);
              },
              selected: (select_figure == selected_figure.RECTANGULO) ? true : false,
              icon: Icons.trip_origin,
              description: "Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Fusce fermentum. Vestibulum turpis sem, aliquet eget, lobortis pellentesque, rutrum eu, nisl.",),
            tipoDeFigura(
              callback: () {
                this.select_figure = selected_figure.ELIPSE;
                Navigator.of(context).pop(selected_figure.ELIPSE);
              },
              selected: (select_figure == selected_figure.ELIPSE) ? true :false,
              icon: Icons.trip_origin,
              description: "Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Fusce fermentum. Vestibulum turpis sem, aliquet eget, lobortis pellentesque, rutrum eu, nisl.",),

          ],
        ),
      ),
    );
  }

}