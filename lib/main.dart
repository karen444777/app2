import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Lista de personas
  List<Persona> _persona = [
    Persona('Feid', 'González', '20191907'),
    Persona('Karen', 'González', '20195579'),
  ];

  // Función para agregar una persona
  void _agregarPersona() {
    setState(() {
      _persona.add(Persona('Nuevo', 'Alumno', '00000000')); // Agrega la misma persona por ahora
    });
  }

  // Función para borrar una persona
  void _borrarPersona(int index) {
    setState(() {
      _persona.removeAt(index); // Elimina la persona en la posición dada
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Listado de alumnos',
          style: TextStyle(
            color: Colors.purple,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.people_alt_rounded),
        backgroundColor: Colors.green,
        onPressed: _agregarPersona, // Llamamos a la función al presionar el botón
      ),
      body: ListView.builder(
        itemCount: _persona.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_persona[index].nombre + ' ' + _persona[index].apellido),
            subtitle: Text(_persona[index].cuenta),
            leading: CircleAvatar(
              child: Text(_persona[index].nombre.substring(0, 1)),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min, // Ajusta el tamaño de la fila al contenido
              children: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _borrarPersona(index), // Elimina la persona al hacer clic
                ),
                Icon(Icons.arrow_forward_ios), // Flecha al lado del botón borrar
              ],
            ),
          );
        },
      ),
    );
  }
}

class Persona {
  String nombre;
  String apellido;
  String cuenta;

  Persona(this.nombre, this.apellido, this.cuenta);
}