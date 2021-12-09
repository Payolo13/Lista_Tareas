import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  TextEditingController TitleController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  String type = '';
  String task = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff1d1e26),
            Color(0xff252041),
          ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Crear',
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Nueva Lista',
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 25),
                    label('Titulo de la tarea'),
                    const SizedBox(
                      height: 12,
                    ),
                    title(),
                    const SizedBox(
                      height: 30,
                    ),
                    label('Nivel de importancia'),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        taskSelect('Importante', 0xff2664fa),
                        const SizedBox(
                          width: 20,
                        ),
                        taskSelect('Planeado', 0xff2bc89d9),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    label('Descripción'),
                    const SizedBox(
                      height: 12,
                    ),
                    description(),
                    const SizedBox(
                      height: 25,
                    ),
                    label('Categoria'),
                    const SizedBox(
                      height: 25,
                    ),
                    Wrap(
                      children: [
                        categorySelect('Investigacion', 0xffff00ff),
                        const SizedBox(
                          width: 20,
                        ),
                        categorySelect('Presentacion', 0xff9457eb),
                        const SizedBox(
                          width: 20,
                        ),
                        categorySelect('Practica', 0xffee82ee),
                        const SizedBox(
                          width: 20,
                        ),
                        categorySelect('Informe', 0xff967bb6),
                        const SizedBox(
                          width: 20,
                        ),
                        categorySelect('Tesis', 0xfffba0e3),
                        const SizedBox(
                          width: 20,
                        ),
                        categorySelect('Examen', 0xfffc8eac),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    button(),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection('Tareas').add({
          'title': TitleController.text,
          'type': type,
          'task': task,
          'description': DescriptionController.text,
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color(0xff8a32f1),
              Color(0xffad32f9),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            'Agregar Tarea',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: DescriptionController,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        maxLines: null,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Descripción',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
        ),
      ),
    );
  }

  Widget taskSelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          type = label;
        });
      },
      child: Chip(
        backgroundColor: type == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: type == label ? Colors.black : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          task = label;
        });
      },
      child: Chip(
        backgroundColor: task == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: task == label ? Colors.black : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: TitleController,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Titulo Tarea',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16.5,
        letterSpacing: 0.2,
      ),
    );
  }
}
