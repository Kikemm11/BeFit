import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> items = ['Entrenamiento 1', 'Entrenamiento 2', 'Entrenamiento 3'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('BeFit'),
          backgroundColor: Colors.cyan[600],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.cyan[600]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Perfil',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30, // Slightly smaller icon
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ListTile(title: Text('Nombre: Iván Maldonado'), onTap: () {}),
                    Divider(thickness: 0.5),
                    ListTile(title: Text('Edad: 23'), onTap: () {}),
                    Divider(thickness: 0.5),
                    ListTile(title: Text('Género: Masculino'), onTap: () {}),
                    Divider(thickness: 0.5),
                    ListTile(title: Text('Biotipo: Mesomorfo'), onTap: () {}),
                    Divider(thickness: 0.5),
                    ListTile(title: Text('Altura: 1.67 mts'), onTap: () {}),
                    Divider(thickness: 0.5),
                    ListTile(title: Text('Peso: 52.00 Kg'), onTap: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: items.map((item) => _buildCard(item)).toList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              items.add('Nuevo Entrenamiento');
            });
          },
          backgroundColor: Colors.cyan[200],
          child: Icon(Icons.fitness_center_outlined, color: Colors.blue,),
        ),
      ),
    );
  }

  Widget _buildCard(String title) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(title, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
