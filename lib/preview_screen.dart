import 'package:flutter/material.dart';
import 'chat_service.dart';
import 'chat_screen.dart';

class PreviewScreen extends StatefulWidget {
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  List<Map<String, dynamic>> previews = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    ChatService().obtenerPreviews().then((data) {
      setState(() {
        previews = data;
        cargando = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chats recientes")),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: previews.length,
              itemBuilder: (context, index) {
                final item = previews[index];
                return ListTile(
                  title: Text(item["nombre"] ?? item["idCliente"]),
                  subtitle: Text(item["mensaje"]),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        idCliente: item["idCliente"],
                        nombre: item["nombre"],
                      ),
                    ));
                  },
                );
              },
            ),
    );
  }
}
