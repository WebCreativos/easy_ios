import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class FechaDeNacimiento extends StatefulWidget {
  String fecha = "";

  @override
  _FechaDeNacimientoState createState() => _FechaDeNacimientoState();
}

class _FechaDeNacimientoState extends State<FechaDeNacimiento> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top:10,bottom:10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Color(0xFF5937b2),
                    width: 1.0,
                    style: BorderStyle.solid))),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Fecha de nacimiento: ${widget.fecha}",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300)),
          ),
          onTap: () => DatePicker.showDatePicker(context,
              pickerTheme: DateTimePickerTheme(
                showTitle: true,
                confirm:
                    Text('Confirmar', style: TextStyle(color: Colors.cyan)),
                cancel: Text('Cancelar', style: TextStyle(color: Colors.red)),
              ),
              minDateTime: DateTime.parse("1920-01-01"),
              maxDateTime: DateTime.parse("${DateTime.now().year}-12-31"),
              initialDateTime: DateTime.parse("${DateTime.now().year}-01-01"),
              dateFormat: "dd-MMMM-yyyy",
              locale: DateTimePickerLocale.es,
              onChange: (date, index) {
                setState(() {
                  widget.fecha = "${date.day}/${date.month}/${date.year}";
                });
              },
              onConfirm: (date, index) {
            setState(() {
              widget.fecha = "${date.day}/${date.month}/${date.year}";
            });
          }),
        ));
  }
}
