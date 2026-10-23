# Revisão de desenvolvimento

## Escopo

Revisão baseada em organização por funcionalidade, responsabilidade única, dependências substituíveis, testes, CI e documentação. O padrão foi escolhido para o código existente, sem impor MVVM/Clean Architecture ou uma biblioteca específica a linguagens e projetos onde não se aplicam.

## Stack e bibliotecas

Flutter/Dart e http.

## Funcionalidades existentes

- Consulta de cotações.
- conversão BRL/USD/EUR.
- tratamento de entrada decimal.

## Organização e responsabilidades

`features/converter` reúne dados e apresentação. `RatesRepository` recebe cliente HTTP e valida respostas; `ExchangeRates` contém as conversões. `main.dart` inicializa o aplicativo. Estado local da tela é suficiente; não há necessidade de Cubit para três campos.

SOLID foi usado como critério para fronteiras concretas: agrupar o que muda junto, evitar regras de negócio duplicadas em UI e permitir substituir acessos externos onde foram extraídos serviços/repositórios. Não significa criar uma interface para cada classe ou afirmar que cada fluxo foi formalmente verificado.

## Verificação reproduzível

Execute a partir da raiz do repositório, salvo o `cd` indicado:

```sh
flutter pub get
flutter analyze --no-fatal-infos --no-fatal-warnings
flutter test
```

Conversão nas três moedas, cotação zero/ausente, erro HTTP e callback do campo. Requer HGBRASIL_API_KEY para consulta real.

A CI correspondente está em `.github/workflows`. Os testes cobrem os comportamentos descritos; não são garantia de ausência de todos os bugs. A análise Flutter mantém avisos e sugestões visíveis, bloqueando erros de compilação/análise. Serviços externos exigem configurações próprias.

## Aplicação do feedback

| Feedback | Tratamento neste projeto |
|---|---|
| Organização e feature-first | Decisão e caminhos descritos acima; módulos simples mantidos quando já coesos. |
| SOLID e arquitetura | Fronteiras entre apresentação, regras e acesso externo revisadas conforme a tecnologia. |
| Gerenciamento de estado | Escolha contextual; recomendações Flutter não são impostas aos demais projetos. |
| Testes | Comandos e cobertura real descritos acima, incluindo limites de integração. |
| Pipeline | Workflows existentes revisados; CI executa verificações apropriadas ao tipo de projeto. |
| README | Descrição, stack, funcionalidades, execução/validação e situação de licença documentadas. |
| Evolução contínua | Rotina manual em `CONTRIBUTING.md`; novas funcionalidades só quando tiverem propósito concreto. |

## Limites externos

Não foram inventadas funcionalidades, resultados de treinamento, métricas de cobertura ou licenças. Revogação de credenciais e configuração de serviços dependem da conta proprietária. Este registro descreve a revisão do código e não substitui uma auditoria de segurança ou homologação completa.
