import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerador de QR Code',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3157A4)),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const GeradorQrPage(),
    );
  }
}

class GeradorQrPage extends StatefulWidget {
  const GeradorQrPage({super.key});

  @override
  State<GeradorQrPage> createState() => _GeradorQrPageState();
}

class _GeradorQrPageState extends State<GeradorQrPage> {
  final TextEditingController _controlador = TextEditingController();
  String? _textoQr;

  void _gerarQrCode() {
    final texto = _controlador.text.trim();

    if (texto.isEmpty) {
      setState(() => _textoQr = null);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite um texto ou link para gerar o QR Code.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _textoQr = texto);
  }

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de QR Code'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.qr_code_2_rounded,
                    size: 72,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Transforme textos e links em QR Codes',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Digite o conteúdo abaixo e toque em “Gerar QR Code”.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    key: const Key('qr-input'),
                    controller: _controlador,
                    minLines: 1,
                    maxLines: 4,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _gerarQrCode(),
                    decoration: const InputDecoration(
                      labelText: 'Texto ou link',
                      hintText: 'Ex.: https://www.exemplo.com',
                      prefixIcon: Icon(Icons.edit_note),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    key: const Key('generate-qr-button'),
                    onPressed: _gerarQrCode,
                    icon: const Icon(Icons.qr_code),
                    label: const Text('Gerar QR Code'),
                  ),
                  if (_textoQr != null) ...[
                    const SizedBox(height: 28),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              'Seu QR Code',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            QrImageView(
                              data: _textoQr!,
                              version: QrVersions.auto,
                              size: 220,
                              semanticsLabel: 'QR Code gerado',
                            ),
                            const SizedBox(height: 12),
                            SelectableText(
                              _textoQr!,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
