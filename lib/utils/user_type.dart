enum user_types{
  Personal_trainer,
  Cliente_gimnasio,
  Admin_gym,
  Cliente_normal
}
/*
("Personal trainer","Personal trainer"),
("Cliente gimnasio","Cliente gimnasio"),
("Admin Gym","Admin Gym"),
("Cliente normal","Cliente normal"),

 */

abstract class UserType {

  factory UserType._() => null;

  String userTypeString(user_types userType){

    switch(userType){
      case user_types.Personal_trainer:
        return "Personal trainer";
      case user_types.Cliente_gimnasio:
        return "Cliente gimnasio";
      case user_types.Admin_gym:
        return "Admin Gym";
      case user_types.Cliente_normal:
        return "Cliente normal";
    }
  }
}