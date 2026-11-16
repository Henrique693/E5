# GQR — Gerador de QR Code

Aplicativo Flutter simples para transformar textos e links em QR Codes.

## Funcionalidades

- Recebe um texto ou endereço de internet.
- Gera um QR Code a partir do conteúdo informado.
- Valida o campo vazio antes de gerar.
- Permite selecionar/copiar o conteúdo apresentado.

## Requisitos

- Flutter SDK compatível com o intervalo Dart declarado em `pubspec.yaml`.
- Dependências resolvidas por `flutter pub get`.

## Executar

```bash
flutter pub get
flutter run
```

## Validar

```bash
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
```

## Builds

```bash
flutter build apk --release
flutter build web --release
```

A dependência de geração do QR Code é `qr_flutter`. As versões resolvidas estão registradas em `pubspec.lock`.
