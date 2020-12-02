import 'package:easygymclub/User/bloc/agenda_bloc.dart';
import 'package:easygymclub/User/ui/screens/agenda/widgets/bottombar_agenda.dart';
import 'package:easygymclub/User/ui/screens/agenda/widgets/lista_de_actividades_agendadas.dart';
import 'package:easygymclub/utils/format_date_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

/*
* AgendaScreen conformado por:
* CalendarCarousel ( brindado por el paqute flutter_calendar_carousel
* ListaDeActividadesAgendadas (FutureBuilder para traer las actividades del usuario, guardadas en SQLITE
* BottombarAgenda ( FutureBuilder encargado de traer las actividades disponibles el dia seleccionado )
* */

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> with FormatDateMixin{
  DateTime _currentDate;
  AgendaBloc _agendaBloc;

  @override
  void initState() {
    _currentDate = DateTime.now();

    // Inicializamos AgendaBloc para poder escuchar
    // si la actividad se registro correctamente.
    // En caso de haberlo hecho volver a "imprimir"

    // Tambien proveemos AgendaBloc a los hijos,
    // donde solo el hijo BottombarAgenda lo usara
    // para poder comunicarse con el padre a la hora de
    // confirmar el registro de la actividad
    _agendaBloc = AgendaBloc();
    _agendaBloc.isAgendadaCorrectamente().listen((data){
      setState(() {
        print("Nueva actividad agendada");
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _agendaBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _agendaBloc,
      child: Container(
        //height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
              ),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01),
              child: CalendarCarousel<Event>(
                iconColor: Colors.white,
                daysTextStyle: TextStyle(color: Colors.white),
                onDayPressed: (DateTime date, List<Event> events) {
                  setState(() {
                    _currentDate = date;
                  });
                },
                weekendTextStyle: TextStyle(
                  color: Colors.red,
                ),
                thisMonthDayBorderColor: Colors.grey,
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
                headerTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                customDayBuilder: (

                    /// you can provide your own build function to make custom day containers
                    bool isSelectable,
                    int index,
                    bool isSelectedDay,
                    bool isToday,
                    bool isPrevMonthDay,
                    TextStyle textStyle,
                    bool isNextMonthDay,
                    bool isThisMonthDay,
                    DateTime day,) {
                  /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
                  /// This way you can build custom containers for specific days only, leaving rest as default.

                  // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
                  /*if (day.day == 15) {
                    return Center(
                      child: Icon(
                          Icons.directions_run,
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return null;
                  }

                   */
                },
                weekFormat: false,
                //markedDatesMap: _markedDateMap,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.5,
                selectedDateTime: _currentDate,
                weekdayTextStyle:
                TextStyle(color: Colors.white, fontSize: 14.0),
                daysHaveCircularBorder: true,

                /// null for not rendering any border, true for circular border, false for rectangular border
              ),
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.24,
              padding: EdgeInsets.only(
                  bottom: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02,
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02
              ),
              child: ListaDeActividadesAgendadas(date: _currentDate,),
            ),
            BottombarAgenda(date: _currentDate,),
          ],
        ),
      ),
    );
  }

}
