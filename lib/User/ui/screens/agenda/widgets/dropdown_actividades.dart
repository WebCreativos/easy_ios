import 'package:flutter/material.dart';

class DropdownActividades extends StatefulWidget{

  final List<String> actividades;
  final Color color;
  final TextStyle textStyle;

  String value = "Selecciona actividad";
  String aux;

  String getValue() => value;
  bool isSelected () => (value != aux) ? true : false;

  DropdownActividades({Key key, this.actividades,this.color,this.textStyle,this.value}){
    aux = value;
  }

  @override
  State<StatefulWidget> createState() {
    return _DropdownActividades();
  }

}

class _DropdownActividades extends State<DropdownActividades>{

  @override
  Widget build(BuildContext context) {

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: widget.color,
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        style: widget.textStyle,
        value: widget.value,
        icon: Icon(Icons.arrow_downward,color:widget.color),
        onChanged: (String newValue) {
          setState(() {
            widget.value = newValue;
          });
        },
        items: widget.actividades
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        })
            .toList(),
      ),
    );
  }

}