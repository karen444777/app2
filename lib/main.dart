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
    Persona('Janet', 'Mancilla', '2019300603'),
    Persona('Karen', 'González', '20190701'),
    
  ];

  // Función para abrir la pantalla de agregar persona
  void _agregarPersona() async {
    final nuevaPersona = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgregarPersona(),
      ),
    );

    if (nuevaPersona != null) {
      setState(() {
        _persona.add(nuevaPersona); // Agregar la persona nueva a la lista
      });
    }
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
            color: Colors.black, // Color del texto negro
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue, // Color de fondo azul
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

// Clase Persona
class Persona {
  String nombre;
  String apellido;
  String cuenta;

  Persona(this.nombre, this.apellido, this.cuenta);
}

// Pantalla para agregar una nueva persona
class AgregarPersona extends StatefulWidget {
  @override
  _AgregarPersonaState createState() => _AgregarPersonaState();
}

class _AgregarPersonaState extends State<AgregarPersona> {
  final _formKey = GlobalKey<FormState>();

  String _nombre = '';
  String _apellido = '';
  String _cuenta = '';

  // Función para manejar el envío del formulario
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final nuevaPersona = Persona(_nombre, _apellido, _cuenta);
      Navigator.of(context).pop(nuevaPersona); // Regresamos la nueva persona a la pantalla anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar nuevo alumno'),
        backgroundColor: Colors.purple, // Color de fondo
      ),
      body: Container(
        color: const Color.fromARGB(255, 252, 251, 252), // Fondo morado claro
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(color: Colors.black), // Texto en negro
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa el nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nombre = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Apellido',
                  labelStyle: TextStyle(color: Colors.black), // Texto en negro
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa el apellido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _apellido = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Número de cuenta',
                  labelStyle: TextStyle(color: Colors.black), // Texto en negro
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa el número de cuenta';
                  }
                  return null;
                },
                onSaved: (value) {
                  _cuenta = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Agregar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
