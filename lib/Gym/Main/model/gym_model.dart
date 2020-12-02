class GymModel {
  int pk;
  String nombre;
  int administrador;
  String direccion;
  String descripcion;
  int telefono;
  double  latitud;
  double longitud;

  GymModel({
    this.pk,
    this.nombre,
    this.direccion,
    this.descripcion,
    this.telefono,
    this.latitud,
    this.longitud,
  });

  GymModel.fromJson(Map < String, dynamic > json){
    this.pk = json["pk"];
    this.nombre = json["nombre"];
    this.direccion = json["direccion"];
    this.descripcion = json["descripcion"];
    this.telefono = json["telefono"];
    this.latitud = json["latitud"];
    this.longitud = json["longitud"];
  }
}