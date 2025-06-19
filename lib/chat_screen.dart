import 'package:flutter/material.dart';
import 'chat_service.dart';

class ChatScreen extends StatefulWidget {
  final String idCliente;
  final String nombre;

  ChatScreen({required this.idCliente, required this.nombre});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, dynamic>> mensajes = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    ChatService().obtenerHistorial(widget.idCliente).then((data) {
      setState(() {
        mensajes = data;
        cargando = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.nombre)),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: mensajes.length,
              itemBuilder: (context, index) {
                final mensaje = mensajes[index];
                final esCliente = mensaje["origen"] == "cliente";

                return Align(
                  alignment: esCliente ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: esCliente ? Colors.grey[200] : Colors.blue[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(mensaje["mensaje"]),
                  ),
                );
              },
            ),
    );
  }
}
