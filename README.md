# Conversor de Moedas

## Descrição

Aplicativo Flutter para consultar cotações da HG Brasil e converter valores entre real, dólar e euro. A consulta real exige uma chave de API configurada no ambiente de execução.

## Stack e bibliotecas

Flutter/Dart e http.

Dependências e versões declaradas: [pubspec.yaml](pubspec.yaml).

## Funcionalidades

- Consulta de cotações.
- Conversão BRL/USD/EUR.
- Tratamento de entrada decimal.

## Licença

Não há uma licença de distribuição definida para este repositório. Nenhuma licença MIT, Apache ou equivalente é concedida por este README. As atribuições e os direitos dos materiais de terceiros permanecem preservados.

## Validação e limites

Conversão nas três moedas, cotação zero/ausente, erro HTTP e callback do campo. Requer HGBRASIL_API_KEY para consulta real.

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

## Organização e manutenção

`features/converter` reúne dados e apresentação. `RatesRepository` recebe cliente HTTP e valida respostas; `ExchangeRates` contém as conversões. `main.dart` inicializa o aplicativo. Estado local da tela é suficiente; não há necessidade de Cubit para três campos.

Veja [a revisão de desenvolvimento](docs/REVISAO.md) para decisões, testes e limites, e [o guia de contribuição](CONTRIBUTING.md) para o fluxo de manutenção.
