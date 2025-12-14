import 'package:flutter/material.dart';
import 'package:web_admin_tenis/models/jugador_model.dart';
import 'package:web_admin_tenis/services/jugador_service.dart';

class JugadoresScreen extends StatefulWidget {
  const JugadoresScreen({super.key});

  @override
  State<JugadoresScreen> createState() => _JugadoresScreenState();
}

class _JugadoresScreenState extends State<JugadoresScreen> {
  final JugadorService _service = JugadorService();
  List<Jugador> _jugadores = [];
  bool _isLoading = true;

  Future<void> _cargarJugadores() async {
    setState(() => _isLoading = true);

    final lista = await _service.getJugadores();
    setState(() {
      _jugadores = lista;
      _isLoading = false;
    });
  }

  void _mostrarDialogoNuevoJugador() {
    final nombreCtrl = TextEditingController();
    final fotoCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Nuevo Jugador"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nombreCtrl,
              decoration: const InputDecoration(
                labelText: "Nombre",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: fotoCtrl,
              decoration: const InputDecoration(
                labelText: "URL Foto",
                prefixIcon: Icon(Icons.image),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          FilledButton(
            onPressed: () async {
              if (nombreCtrl.text.isEmpty) return;
              Navigator.pop(context);

              final nuevo = Jugador(
                nombre: nombreCtrl.text,
                foto: fotoCtrl.text,
                jugadorId: '',
              );

              final exito = await _service.crearJugador(nuevo);
              if (exito) {
                _cargarJugadores();
                if (mounted) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Jugador añadido")),
                  );
                }
              }
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gestión de Jugadores")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _mostrarDialogoNuevoJugador,
        label: const Text("Añadir Jugador"),
        icon: const Icon(Icons.add),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: _jugadores.length,
              itemBuilder: (context, index) {
                final j = _jugadores[index];
                return Card(
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: j.foto!.isNotEmpty
                            ? Image.network(j.foto!, fit: BoxFit.cover)
                            : const Icon(Icons.person, size: 50),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          j.nombre!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
