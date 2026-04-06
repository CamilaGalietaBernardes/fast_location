# FastLocation

Aplicativo mobile desenvolvido em Flutter para consulta de CEP e endereços, criado para a empresa fictícia **FastDelivery**.

## Funcionalidades

- Busca de endereço completo a partir de um CEP
- Busca de CEP a partir de UF, cidade e logradouro
- Histórico de consultas salvo localmente no dispositivo
- Integração com aplicativos de mapa (Google Maps, Waze, etc.)

## Tecnologias utilizadas

| Tecnologia | Finalidade |
|---|---|
| Flutter | Framework mobile multiplataforma |
| Dart | Linguagem de programação |
| MobX | Gerenciamento de estado |
| Hive | Armazenamento local |
| Dio | Requisições HTTP |
| ViaCEP API | Fonte de dados de CEP |
| map_launcher | Integração com mapas |

## Pré-requisitos

Antes de executar o projeto, certifique-se de ter instalado:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versão 3.x ou superior)
- [Android Studio](https://developer.android.com/studio) ou VS Code com extensão Flutter
- Android SDK configurado
- Dispositivo físico Android ou emulador

Verifique se o ambiente está correto:

```bash
flutter doctor
```

## Como executar

### 1. Clone o repositório

```bash
git clone https://github.com/CamilaGalietaBernardes/fast_location.git
cd fast_location
```

### 2. Instale as dependências

```bash
flutter pub get
```

### 3. Gere os arquivos automáticos (MobX e Hive)

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Conecte um dispositivo ou inicie um emulador

Para verificar dispositivos disponíveis:

```bash
flutter devices
```

### 5. Execute o aplicativo

```bash
flutter run
```

Para build de produção (APK):

```bash
flutter build apk --target-platform android-arm64
```

O APK gerado estará em:
```
build/app/outputs/flutter-apk/app-release.apk
```

## Estrutura do projeto

```
lib/
├── main.dart                          # Ponto de entrada da aplicação
└── src/
    ├── models/
    │   └── address_model.dart         # Modelo de resposta da API ViaCEP
    ├── modules/
    │   ├── home/                      # Tela inicial com menu de navegação
    │   ├── cep/                       # Busca de endereço por CEP
    │   ├── address/                   # Busca de CEP por endereço
    │   └── history/                   # Histórico de consultas
    ├── routes/
    │   └── app_routes.dart            # Constantes de rotas
    ├── services/
    │   └── viacep_service.dart        # Integração com a API ViaCEP
    └── shared/
        ├── colors/                    # Paleta de cores do app
        ├── components/                # Widgets reutilizáveis
        ├── metrics/                   # Constantes de espaçamento
        └── storage/                   # Configuração do Hive (armazenamento local)
```

## API utilizada

O app utiliza a [ViaCEP](https://viacep.com.br/), uma API pública e gratuita para consulta de CEPs brasileiros.

- Busca por CEP: `https://viacep.com.br/ws/{CEP}/json/`
- Busca por endereço: `https://viacep.com.br/ws/{UF}/{cidade}/{logradouro}/json/`

Não é necessário cadastro ou chave de API.
