import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:firebase/ui/ciudadano_informacion.dart';
import 'package:firebase/model/ciudadano.dart';
import 'ciudadano_pantalla.dart';

class ListaCiudadano extends StatefulWidget {
  @override
  _ListaCiudadanoState createState() => _ListaCiudadanoState();
}

final ciudadanoReferencia =
    FirebaseDatabase.instance.reference().child('Ciudadano');

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
              var icon2 = Icon(
                Icons.delete,
                color: Colors.red,
              );
              return Column(children: <Widget>[
                Divider(
                  height: 7.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: ListTile(
                      title: Text(
                        '${items[position].cedula}',
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
                              '${position + 1}',
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
                      icon: icon2,
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

  _navegarInformacionCiudadano(
      BuildContext context, Ciudadano ciudadano) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PantallaCiudadano(ciudadano)),
    );
  }

  _visualizarCiudadano(
      BuildContext context, Ciudadano ciudadano, int position) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InformacionCiudadano(ciudadano)),
    );
  }

  _crearCiudadano(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              PantallaCiudadano(Ciudadano(null, '', '', '', ''))),
    );
  }
}
