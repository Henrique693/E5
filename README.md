# E5 — GQR (Gerador de QR Code)

Projeto acadêmico desenvolvido em Flutter/Dart. O aplicativo permite informar um texto ou link e gerar um QR Code correspondente.

## Estrutura

```text
E5/
├── .github/
│   └── workflows/
│       ├── ci.yml
│       └── cd.yml
├── docs/
│   ├── CONFIGURACAO_GITHUB.md
│   ├── Plano_Gerenciamento_Configuracao_GQR_v1.2.docx
│   └── Plano_Gerenciamento_Configuracao_GQR_v1.2.pdf
├── gerador_qr/
│   ├── lib/main.dart
│   ├── test/widget_test.dart
│   ├── pubspec.yaml
│   └── pubspec.lock
└── .gitignore
```

A pasta `gerador_qr/` contém o projeto Flutter. Arquivos temporários de compilação, caches, configurações locais e pastas de IDE não devem ser versionados.

## Executar localmente

É necessário ter o Flutter SDK instalado. No terminal, na pasta do aplicativo:

```bash
cd gerador_qr
flutter pub get
flutter run
```

## Verificações locais

```bash
cd gerador_qr
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
```

## Gerar os artefatos

```bash
cd gerador_qr
flutter build apk --release
flutter build web --release
```

Os artefatos serão gerados em `build/app/outputs/flutter-apk/` e `build/web/`, respectivamente. Essas pastas são geradas novamente pelo Flutter e não devem ser commitadas.

## CI/CD no GitHub

- `CI` executa formatação, análise estática, testes e builds Android/Web em Pull Requests e em atualizações de `main`.
- `CD` é iniciado após uma execução bem-sucedida de `CI` na `main`. O job `staging` confere os artefatos; depois, o job `production` publica uma GitHub Release usando os mesmos artefatos aprovados.
- Os jobs referenciam os GitHub Environments `staging` e `production`. Esses ambientes e suas regras de proteção precisam ser criados nas configurações do repositório.

**Atenção:** os arquivos de workflow estão preparados, mas as regras de proteção da branch, o convite ao par de revisão e os revisores dos environments são configurações da conta/repositório. Siga `docs/CONFIGURACAO_GITHUB.md` antes de considerar os requisitos concluídos.

## Documentação de GCS

O Plano de Gerenciamento de Configuração atualizado está em `docs/Plano_Gerenciamento_Configuracao_GQR_v1.2.pdf` (versão editável em DOCX na mesma pasta).
