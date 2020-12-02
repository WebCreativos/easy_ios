import 'package:decimal/decimal.dart';
import 'package:easygymclub/User/ui/screens/configuracion/bloc/configuration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MinusNumberPlus extends StatefulWidget {

  Function newValue;
  var initValue;
  String tipoMedida = "";

  MinusNumberPlus(
      {@required this.newValue, @required this.initValue, this.tipoMedida});

  @override
  State<StatefulWidget> createState() {
    return _MinusNumberPlus();
  }
}

class _MinusNumberPlus extends State<MinusNumberPlus> {

  var value;
  TextEditingController controllerValue;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    value = widget.initValue;
    controllerValue = TextEditingController(text: value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          padding: const EdgeInsets.all(2.0),
          margin: const EdgeInsets.all(2.0),
          child: Row(
            children: [
              Text(
                "${value.toString()} ${widget.tipoMedida.toLowerCase()}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.0,
                    fontWeight: FontWeight.w500
                ),
              ),
              Icon(Icons.zoom_in, color: Colors.white,)
            ],
          ),
        ),
        onTap: () =>
            showMaterialModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0))),
              backgroundColor: Colors.transparent,
                context: context,
              builder: (context, scrollController) =>
                  AnimatedPadding(
                    padding: MediaQuery
                        .of(context)
                        .viewInsets,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.decelerate,
                    child: new Container(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff260d6c),
                          ),
                          //height: 200,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                InkWell(
                                  // Minus
                                  child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                      size: 28.0
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (value is int) {
                                        value--;
                                      } else {
                                        value =
                                            Decimal.parse(value.toString()) -
                                                Decimal.parse('0.1');
                                        value = value.toDouble();
                                      }
                                      controllerValue.text = value.toString();
                                      widget.newValue(value.toString());
                                    });
                                  },
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      _valueController(),
                                      Text(widget.tipoMedida,
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  // Plus
                                    child: Icon(
                                      Icons.keyboard_arrow_up, color: Colors
                                        .white, size: 28.0,),
                                    onTap: () {
                                      setState(() {
                                        if (value is int) {
                                          value++;
                                        } else {
                                          value =
                                              Decimal.parse(value.toString()) +
                                                  Decimal.parse('0.1');
                                          value = value.toDouble();
                                        }

                                        controllerValue.text = value.toString();
                                        widget.newValue(value.toString());
                                      });
                                    }),
                              ]),
                        ),
                      ),
                    ),
                  ),)
    );
  }

  Widget _valueController() {
    return Container(
        width: 40.0,
        child: TextField(
          inputFormatters: (value is int) ? [
            BlacklistingTextInputFormatter(RegExp("[.]"))
          ] : null,
          textAlign: TextAlign.center,
          controller: controllerValue,
          keyboardType: TextInputType.numberWithOptions(),
          decoration: InputDecoration(
              enabledBorder: null,
              focusedBorder: null
          ),
          style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
              fontWeight: FontWeight.w300
          ),
          onChanged: (newValue) {
            if (value is int) {
              value = int.parse(newValue);
            } else {
              value = Decimal.parse(newValue);
            }
            setState(() {
              widget.newValue(value.toString());
            });
          },
        )
    );
  }

}

