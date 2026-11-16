import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gerador_qr/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  testWidgets('exibe a tela inicial sem QR Code', (WidgetTester tester) async {
    await tester.pumpWidget(const MeuApp());

    expect(find.text('Gerador de QR Code'), findsOneWidget);
    expect(find.byKey(const Key('qr-input')), findsOneWidget);
    expect(find.byType(QrImageView), findsNothing);
  });

  testWidgets('gera um QR Code com o texto informado',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MeuApp());

    await tester.enterText(
      find.byKey(const Key('qr-input')),
      'https://example.com',
    );
    await tester.tap(find.byKey(const Key('generate-qr-button')));
    await tester.pumpAndSettle();

    final qrFinder = find.byType(QrImageView);
    expect(qrFinder, findsOneWidget);
    expect(tester.widget<QrImageView>(qrFinder).data, 'https://example.com');
  });

  testWidgets('informa quando o campo está vazio',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MeuApp());

    await tester.tap(find.byKey(const Key('generate-qr-button')));
    await tester.pump();

    expect(
      find.text('Digite um texto ou link para gerar o QR Code.'),
      findsOneWidget,
    );
    expect(find.byType(QrImageView), findsNothing);
  });
}
