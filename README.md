# Conversor de moedas

Conversão entre real, dólar e euro usando cotações da HG Brasil.

## Stack e organização
Flutter/Dart, HTTP. Defina `HGBRASIL_API_KEY` por `--dart-define`. A consulta exige internet e chave válida; a chave distribuída em um app cliente não é um segredo de servidor.

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
