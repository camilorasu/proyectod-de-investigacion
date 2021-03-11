import 'package:firebase_database/firebase_database.dart';

class Ciudadano {
  String _llave;
  String _cedula;
  String _nombre;
  String _direccion;
  String _email;
  String _telefono;

  Ciudadano(this._llave, this._cedula, this._nombre, this._direccion,
      this._email, this._telefono);

  Ciudadano.map(dynamic obj) {
    this._llave = obj['llave'];
    this._cedula = obj['cedula'];
    this._nombre = obj['nombre'];
    this._direccion = obj['direccion'];
    this._email = obj['email'];
    this._telefono = obj['telefono'];
  }

  String get llave => _llave;
  String get cedula => _cedula;
  String get nombre => _nombre;
  String get direccion => _direccion;
  String get email => _email;
  String get telefono => _telefono;

  Ciudadano.fromSnapShot(DataSnapshot snapshot) {
    _llave = snapshot.key;
    _cedula = snapshot.value['cedula'];
    _nombre = snapshot.value['nombre'];
    _direccion = snapshot.value['direccion'];
    _email = snapshot.value['email'];
    _telefono = snapshot.value['telefono'];
  }
}
