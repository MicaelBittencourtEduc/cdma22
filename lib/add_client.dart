import 'package:cdma22/client_model.dart';
import 'package:cdma22/database.dart';
import 'package:flutter/material.dart';

class AddClient extends StatefulWidget {
  
  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  Map data = {'nome' : '', 'sobrenome' : '', 'marcado' : true};
  bool _checked = true;
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              /*
              Checkbox(
                value: data['value'],
                onChanged: (value){
                  data['value'] = value;
                }),
                */
              TextField(
                onChanged: (value) {
                  data['nome'] = value;
                },
                decoration: InputDecoration(hintText: "Nome"),
              ),
              TextField(
                onChanged: (value) {
                  data['sobrenome'] = value;
                },
                decoration: InputDecoration(hintText: "Sobrenome"),
              ),
              Checkbox(
                value: data['marcado'],
                onChanged: (value){
                  setState(() {
                    data['marcado'] = value;
                  });
                })
            ],
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Cliente  rnd = Cliente(nome: data['nome'], sobrenome: data['sobrenome'], marcado: data['marcado']);
          DBProvider.db.newCliente(rnd);
          setState(() {});
        },
      ),
    );
  }
}
