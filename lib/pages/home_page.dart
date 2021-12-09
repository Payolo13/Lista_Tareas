import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lista_tareas/custom/list_card.dart';
import 'package:lista_tareas/pages/singup_page.dart';
import 'package:lista_tareas/pages/todo_page.dart';
import 'package:lista_tareas/pages/view_page.dart';
import 'package:lista_tareas/service/auth_service.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('Tareas').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'Lista de Tareas',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await authClass.logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => const SingUp()),
                    (route) => false);
              }),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
              size: 32,
              color: Colors.black,
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (builder) => const ToDo()));
              },
              child: Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Colors.indigoAccent,
                      Colors.purple,
                    ])),
                child: const Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.settings,
              size: 32,
              color: Colors.black,
            ),
            title: Container(),
          ),
        ],
      ),
      //Estructura
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final listas = snapshot.data!.docs;
            return ListView.builder(
              itemCount: listas.length,
              itemBuilder: (context, index) {
                IconData? iconData;
                Color? iconColor;
                Map<String, dynamic> document =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                switch (document['task']) {
                  case 'Investigacion':
                    iconData = Icons.list;
                    iconColor = const Color(0xffff00ff);
                    break;
                  case 'Presentacion':
                    iconData = Icons.list;
                    iconColor = const Color(0xff9457eb);
                    break;
                  case 'Practica':
                    iconData = Icons.list;
                    iconColor = const Color(0xffee82ee);
                    break;
                  case 'Informe':
                    iconData = Icons.list;
                    iconColor = const Color(0xff967bb6);
                    break;
                  case 'Tesis':
                    iconData = Icons.list;
                    iconColor = const Color(0xfffba0e3);
                    break;
                  case 'Examen':
                    iconData = Icons.list;
                    iconColor = const Color(0xfffc8eac);
                    break;
                }
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => ViewP(
                          document: document,
                          id: snapshot.data!.docs[index].id,
                        ),
                      ),
                    );
                  },
                  child: ListC(
                    title: document['title'] == null
                        ? 'Hey There'
                        : document['title'],
                    iconBgColor: Colors.white,
                    iconColor: iconColor,
                    iconData: iconData,
                  ),
                );
              },
            );
          }),
    );
  }
}
