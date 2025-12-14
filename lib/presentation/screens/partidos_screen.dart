import 'package:flutter/material.dart';
import 'package:web_admin_tenis/models/jugador_model.dart';
import 'package:web_admin_tenis/services/partido_service.dart';

class PartidosScreen extends StatefulWidget {
  const PartidosScreen({super.key});

  @override
  State<PartidosScreen> createState() => _PartidosScreenState();
}

class _PartidosScreenState extends State<PartidosScreen> {
  final PartidoService _partidoService = PartidoService();

  final List<Jugador> _jugadores = [];
  bool _isLoading = true;

  final _torneoCtrl = TextEditingController();
  final _rondaCtrl = TextEditingController();
  String? _selectedJ1;
  String? _selectedJ2;
  bool _saqueJ1 = true;

  void _publicarPartido() async {
    if (_torneoCtrl.text.isEmpty ||
        _selectedJ1 == null ||
        _selectedJ2 == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Rellena todos los campos")));
      return;
    }
    if (_selectedJ1 == _selectedJ2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Elige jugadores distintos")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final exito = await _partidoService.crearPartido(
      torneo: _torneoCtrl.text,
      ronda: _rondaCtrl.text,
      idJ1: _selectedJ1!,
      idJ2: _selectedJ2!,
      saqueJ1: _saqueJ1,
    );

    setState(() => _isLoading = false);

    if (exito && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Partido publicado con éxito")),
      );
      Navigator.pop(context);
    } else if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Error al publicar")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Organizar Nuevo Partido")),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Card(
            margin: const EdgeInsets.all(20),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: _isLoading && _jugadores.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Datos del Encuentro",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 15),

                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _torneoCtrl,
                                decoration: const InputDecoration(
                                  labelText: "Torneo",
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.emoji_events),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: TextField(
                                controller: _rondaCtrl,
                                decoration: const InputDecoration(
                                  labelText: "Ronda",
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.timelapse),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdown(
                                "Jugador 1",
                                _selectedJ1,
                                (val) => setState(() => _selectedJ1 = val),
                              ),
                            ),
                            const SizedBox(width: 15),
                            const Text(
                              "VS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _buildDropdown(
                                "Jugador 2",
                                _selectedJ2,
                                (val) => setState(() => _selectedJ2 = val),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        SwitchListTile(
                          title: const Text("¿Quién tiene el saque inicial?"),
                          subtitle: Text(
                            _saqueJ1
                                ? "Saca el Jugador 1"
                                : "Saca el Jugador 2",
                          ),
                          value: _saqueJ1,
                          activeThumbColor: Theme.of(context).primaryColor,
                          onChanged: (val) => setState(() => _saqueJ1 = val),
                        ),

                        const SizedBox(height: 25),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: FilledButton.icon(
                            onPressed: _isLoading ? null : _publicarPartido,
                            icon: const Icon(Icons.send_rounded),
                            label: const Text(
                              "PUBLICAR PARTIDO",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String? value,
    Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: _jugadores
          .map(
            (j) => DropdownMenuItem(
              value: j.jugadorId,
              child: Text(j.nombre!, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
