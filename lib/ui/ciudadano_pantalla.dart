import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase/model/ciudadano.dart';

import '../model/ciudadano.dart';

class PantallaCiudadano extends StatefulWidget {
  final Ciudadano ciudadano;
  PantallaCiudadano(this.ciudadano);

  @override
  _PantallaCiudadanoState createState() => _PantallaCiudadanoState();
}

final ciudadanoReferencia =
    FirebaseDatabase.instance.reference().child('Ciudadano');

class _PantallaCiudadanoState extends State<PantallaCiudadano> {
  List<Ciudadano> items;

  TextEditingController _idController;
  TextEditingController _nombreController;
  TextEditingController _habitacionController;
  TextEditingController _correoController;
  TextEditingController _telefonoController;

  @override
  void initState() {
    super.initState();
    _idController = new TextEditingController(text: widget.ciudadano.cedula);
    _nombreController =
        new TextEditingController(text: widget.ciudadano.nombre);
    _habitacionController =
        new TextEditingController(text: widget.ciudadano.direccion);
    _correoController = new TextEditingController(text: widget.ciudadano.email);
    _telefonoController =
        new TextEditingController(text: widget.ciudadano.telefono);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Ingresar Datos',
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        height: 570,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _idController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), labelText: 'cédula'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Divider(),
                TextField(
                  controller: _nombreController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), labelText: 'Nombre'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Divider(),
                TextField(
                  controller: _habitacionController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.add_location), labelText: 'Dirección'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Divider(),
                TextField(
                  controller: _correoController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.mail_outline), labelText: 'Correo'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Divider(),
                TextField(
                  controller: _telefonoController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone), labelText: 'telefono'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Divider(),
                FlatButton(
                    onPressed: () {
                      if (widget.ciudadano.cedula != null) {
                        ciudadanoReferencia.child(widget.ciudadano.cedula).set({
                          'cedula': _idController.text,
                          'nombre': _nombreController.text,
                          'direccion': _habitacionController.text,
                          'email': _correoController.text,
                          'telefono': _telefonoController.text,
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      } else {
                        ciudadanoReferencia.push().set({
                          'nombre': _nombreController.text,
                          'direccion': _habitacionController.text,
                          'email': _correoController.text,
                          'telefono': _telefonoController.text,
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: (widget.ciudadano.cedula != null)
                        ? Text('Update')
                        : Text('Add')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
