import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '/services/producto_service.dart';
import 'scanner.dart';
import 'package:safe_bite/widgets/info_card.dart';

/// Página de historial de escaneos
class HistoryPage extends StatelessWidget {
  final List<Product> historial;
  const HistoryPage({required this.historial, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: historial.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final prod = historial[index];
            final formattedDate = DateFormat('dd/MM/yyyy HH:mm')
                .format(prod.scannedAt.toLocal());
            return ListTile(
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.fastfood, color: Colors.grey),
              ),
              title: Text(prod.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formattedDate),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: prod.allergens.map((allergen) {
                      return Chip(
                        label: Text(
                          allergen,
                          style: const TextStyle(fontSize: 12),
                        ),
                        visualDensity: VisualDensity.compact,
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      );
}

/// Página de ajustes / logout
class SettingsPage extends StatelessWidget {
  final VoidCallback onLogout;
  const SettingsPage({required this.onLogout, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Center(
          child: ElevatedButton.icon(
            onPressed: onLogout,
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
          ),
        ),
      );
}

/// Pantalla principal con navegación
class PantallaHome extends StatefulWidget {
  const PantallaHome({Key? key}) : super(key: key);

  @override
  _PantallaHomeState createState() => _PantallaHomeState();
}

class _PantallaHomeState extends State<PantallaHome> {
  int _currentIndex = 0;
  int _totalAllergens = 0;
  int _totalScanned = 0;
  List<Product> _historial = [];
  final _api = ProductService();

  @override
  void initState() {
    super.initState();
    _loadHistorial();
  }

  Future<void> _loadHistorial() async {
    final history = await _api.getScanHistory();
    setState(() {
      _historial = history;
      _totalScanned = history.length;
      _totalAllergens = history.fold(0, (sum, p) => sum + p.allergens.length);
    });
  }

  Future<void> _handleCode(String code) async {
    if (code.trim().isEmpty) return;
    final product = await _api.fetchAndSaveProduct(code.trim());
    if (product == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Producto no encontrado')));
      return;
    }
    setState(() {
      _historial.insert(0, product);
      _totalScanned++;
      _totalAllergens += product.allergens.length;
    });
  }

  Future<void> _scan() async {
    final code = await Navigator.push<String?>(
      context,
      MaterialPageRoute(builder: (_) => const ScannerScreen()),
    );
    if (code != null && code.isNotEmpty) {
      await _handleCode(code);
    }
  }

  /// Cierra sesión y regresa a la pantalla de login
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardConManual(
        alergenos: _totalAllergens,
        analizados: _totalScanned,
        onScan: _scan,
        onSubmitCode: _handleCode,
      ),
      HistoryPage(historial: _historial),
      SettingsPage(onLogout: _logout),
    ];
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
    );
  }
}

/// Dashboard con botón de escaneo y entrada manual
class DashboardConManual extends StatefulWidget {
  final int alergenos, analizados;
  final VoidCallback onScan;
  final Future<void> Function(String) onSubmitCode;

  const DashboardConManual({
    required this.alergenos,
    required this.analizados,
    required this.onScan,
    required this.onSubmitCode,
    Key? key,
  }) : super(key: key);

  @override
  _DashboardConManualState createState() => _DashboardConManualState();
}

class _DashboardConManualState extends State<DashboardConManual> {
  final _manualCtrl = TextEditingController();

  @override
  void dispose() {
    _manualCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(
                    icon: Icons.warning_amber_outlined,
                    conteo: widget.alergenos.toString(),
                    texto: 'alérgenos\ndetectados',
                    color: Colors.greenAccent,
                  ),
                  InfoCard(
                    icon: Icons.qr_code,
                    conteo: widget.analizados.toString(),
                    texto: 'productos\nanalizados',
                    color: Colors.lightBlueAccent,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: widget.onScan,
                icon: const Icon(Icons.qr_code_scanner, size: 28),
                label: const Text('ESCANEAR CÓDIGO', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C853),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  minimumSize: const Size.fromHeight(56),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _manualCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Código de barras',
                  hintText: 'Escribe o pega el EAN',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () async {
                      final code = _manualCtrl.text.trim();
                      if (code.isNotEmpty) {
                        await widget.onSubmitCode(code);
                        _manualCtrl.clear();
                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),
                ),
                onSubmitted: (value) async {
                  final code = value.trim();
                  if (code.isNotEmpty) {
                    await widget.onSubmitCode(code);
                    _manualCtrl.clear();
                    FocusScope.of(context).unfocus();
                  }
                },
              ),
            ],
          ),
        ),
      );
}
