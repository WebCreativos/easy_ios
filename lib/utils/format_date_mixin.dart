abstract class FormatDateMixin {
  // This class is intended to be used as a mixin, and should not be
  // extended directly.
  factory FormatDateMixin._() => null;


  //Formateo de fecha

  String dateToString(DateTime date){
    return "${date.year}-${(date.month >= 10) ? date.month : "0${date.month}"}-${(date.day >= 10) ? date.day : "0${date.day}"}";
  }

  DateTime stringToDate(String date,String hora){

    int day = int.parse(date.split('-').last);
    int month = int.parse(date.split('-')[1]);
    int year = int.parse(date.split('-').first);

    int hour = int.parse(hora.split(':').first);
    int minute = int.parse(hora.split(':')[1]);

    return DateTime(year,month,day,hour,minute);
  }
}