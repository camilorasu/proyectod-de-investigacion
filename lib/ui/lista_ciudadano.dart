import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:firebase/ui/ciudadano_informacion.dart';
import 'package:firebase/ui/lista_ciudadano.dart';
import 'package:firebase/model/ciudadano.dart';

class ListaCiudadano extends StatefulWidget {
  @override
  _ListaCiudadanoState createState() => _ListaCiudadanoState();
}

final ciudadanoReferencia =
    FirebaseDatabase.instance.reference().child('ciudadano');

class _ListaCiudadanoState extends State<ListaCiudadano> {
  List<Ciudadano> items;
  StreamSubscription<Event> _adicionarCiudadano;
  StreamSubscription<Event> _editarCiudadano;

  @override
  void initState() {
    super.initState();
    items = new List();
    _adicionarCiudadano = ciudadanoReferencia.onChildAdded.listen(_adicionar);
    _editarCiudadano = ciudadanoReferencia.onChildChanged.listen(_editar);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _adicionarCiudadano.cancel();
    _editarCiudadano.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Base de datos ciudadanos',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Información del ciudadano',
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
          child: ListView.builder(
            itemCount: items.length,
            padding: EdgeInsets.only(top: 12.0),
            itemBuilder: (context, position) {
              return Column(children: <Widget>[
                Divider(
                  height: 7.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: ListTile(
                      title: Text(
                        '${items[position].nombre}',
                        style: TextStyle(color: Colors.orange, fontSize: 21.0),
                      ),
                      subtitle: Text(
                        '${items[position].nombre}',
                        style: TextStyle(
                            color: Colors.orangeAccent[30], fontSize: 21.0),
                      ),
                      leading: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.amberAccent,
                            radius: 17.0,
                            child: Text(
                              '${items[position].nombre}',
                              style: TextStyle(
                                  color: Colors.orangeAccent[30],
                                  fontSize: 21.0),
                            ),
                          )
                        ],
                      ),
                      onTap: () => _navegarInformacionCiudadano(
                          context, items[position]),
                    )),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () =>
                          _borrarCiudadano(context, items[position], position),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                      onPressed: () => _visualizarCiudadano(
                          context, items[position], position),
                    )
                  ],
                )
              ]);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepOrangeAccent,
          onPressed: () => _crearCiudadano(context),
        ),
      ),
    );
  }

  void _adicionar(Event event) {
    setState(() {
      items.add(new Ciudadano.fromSnapShot(event.snapshot));
    });
  }

  void _editar(Event event) {
    var infoCiudadano = items
        .singleWhere((ciudadano) => ciudadano.cedula == event.snapshot.key);
    setState(() {
      items[items.indexOf(infoCiudadano)] =
          new Ciudadano.fromSnapShot(event.snapshot);
    });
  }

  _borrarCiudadano(
      BuildContext context, Ciudadano ciudadano, int position) async {
    await ciudadanoReferencia.child(ciudadano.cedula).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  _navegarInformacionCiudadano(BuildContext context, Ciudadano item) {}

  _visualizarCiudadano(BuildContext context, Ciudadano item, int position) {}

  _crearCiudadano(BuildContext context) {}
}
