import 'package:cdma22/add_client.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'client_model.dart';
import 'database.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // data for testing
  List<Cliente> testClients = [
    Cliente(nome: "Dick", sobrenome: "Vigarista", marcado: false),
    Cliente(nome: "Penélope", sobrenome: "Charmosa", marcado: true),
    Cliente(nome: "Medinho", sobrenome: "Beltrano", marcado: false),
    Cliente(nome: "Muttley", sobrenome: "Siclano", marcado: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CDMA22 - Clientes"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              DBProvider.db.deleteAll();
              setState(() {});
            },
          )
        ],
      ),
      body: FutureBuilder<List<Cliente>>(
        future: DBProvider.db.getAllClientes(),
        builder: (BuildContext context, AsyncSnapshot<List<Cliente>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Cliente item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    DBProvider.db.deleteCliente(item.id);
                  },
                  child: ListTile(
                    title: Text(item.nome + " " + item.sobrenome),
                    leading: Text(item.id.toString()),
                    trailing: Checkbox(
                      onChanged: (bool value) {
                        DBProvider.db.blockOrUnblock(item);
                        setState(() {});
                      },
                      value: item.marcado,
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.push(context, 
            MaterialPageRoute(builder: (context)=>  AddClient()),
          );
        },
      ),
    );
  }
}
