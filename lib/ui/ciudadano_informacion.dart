import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase/model/ciudadano.dart';

import '../model/ciudadano.dart';

class InformacionCiudadano extends StatefulWidget {
  final Ciudadano ciudadano;
  InformacionCiudadano(this.ciudadano);
  @override
  _InformacionCiudadanoState createState() => _InformacionCiudadanoState();
}

final ciudadanoReferencia =
    FirebaseDatabase.instance.reference().child('Ciudadano');

class _InformacionCiudadanoState extends State<InformacionCiudadano> {
  List<Ciudadano> items;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Información del ciudadano',
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        height: 400.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                new Text(
                  "Cédula : ${widget.ciudadano.cedula}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                new Text(
                  "Nombre : ${widget.ciudadano.nombre}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                new Text(
                  "Habitación : ${widget.ciudadano.direccion}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                new Text(
                  "Correo : ${widget.ciudadano.email}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                new Text(
                  "Teléfono : ${widget.ciudadano.telefono}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
