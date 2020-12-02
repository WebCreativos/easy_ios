class MetasModel {

  String nombre;
  String descripcion;
  int  puntos;

  MetasModel({
    this.nombre,
    this.descripcion,
    this.puntos,
  });

  MetasModel.fromJson(Map < String, dynamic > json){
    this.nombre = json["nombre"];
    this.descripcion = json["descripcion"];
    this.puntos = json["puntos"];
  }
}