

class DietaModel {

  String nombre;
  Map dietas;
  String imgPath;

  DietaModel({this.nombre,this.dietas,this.imgPath});

  DietaModel.fromJson(Map<String,dynamic> json)
      : nombre = json['nombre'],
        imgPath = "https://app.easygymclub.com${json['main_image']}",
        dietas = json['dietas'];

  Map<String, dynamic> toMap() =>{
      'nombre': this.nombre,
      'imgPath': this.imgPath, 
  };
}