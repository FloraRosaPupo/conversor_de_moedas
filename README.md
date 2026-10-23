# Conversor de moedas

Conversão entre real, dólar e euro usando cotações da HG Brasil.

## Stack e organização
Flutter/Dart e http.

`features/converter` reúne dados e apresentação. `RatesRepository` recebe cliente HTTP e valida respostas; `ExchangeRates` contém as conversões. `main.dart` inicializa o aplicativo. Estado local da tela é suficiente; não há necessidade de Cubit para três campos.

## Executar
Use a versão de Flutter registrada em `.github/workflows/ci.yml`.
```sh
git clone https://github.com/FloraRosaPupo/conversor_de_moedas.git
cd conversor_de_moedas
flutter pub get
flutter run --dart-define=HGBRASIL_API_KEY=SUA_CHAVE
```

## Verificações
```sh
flutter analyze --no-fatal-infos --no-fatal-warnings
flutter test
```
A CI verifica erros de análise e os testes. Avisos e sugestões continuam visíveis no relatório do analisador. Testes locais não substituem a validação no dispositivo e dos serviços externos.

## Contribuir
Abra uma branch por alteração, descreva o comportamento esperado e inclua testes para regras ou regressões. Mantenha credenciais e arquivos gerados fora do Git.

## Licença
Não há licença de distribuição definida neste repositório.


## Funcionalidades

- Consulta de cotações.
- conversão BRL/USD/EUR.
- tratamento de entrada decimal.


## Organização e manutenção

`features/converter` reúne dados e apresentação. `RatesRepository` recebe cliente HTTP e valida respostas; `ExchangeRates` contém as conversões. `main.dart` inicializa o aplicativo. Estado local da tela é suficiente; não há necessidade de Cubit para três campos.

Veja [a revisão de desenvolvimento](docs/REVISAO.md) para decisões, testes e limites, e [o guia de contribuição](CONTRIBUTING.md) para o fluxo de manutenção.
