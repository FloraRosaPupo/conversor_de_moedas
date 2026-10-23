import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_application_4/features/converter/data/rates_repository.dart';

void main() {
  test('converte entre as três moedas sem arredondamento intermediário', () {
    final rates = ExchangeRates(dollar: 5, euro: 6);
    expect(rates.convert(30, Currency.real, Currency.dollar), 6);
    expect(rates.convert(6, Currency.dollar, Currency.euro), 5);
    expect(rates.convert(5, Currency.euro, Currency.real), 30);
    expect(() => ExchangeRates(dollar: 0, euro: 6), throwsFormatException);
  });
  test('parse aceita cotações inteiras e rejeita dados ausentes', () {
    final rates = ExchangeRates.fromJson({
      'results': {
        'currencies': {
          'USD': {'buy': 5},
          'EUR': {'buy': 6}
        }
      }
    });
    expect(rates.dollar, 5.0);
    expect(() => ExchangeRates.fromJson({}), throwsFormatException);
  });
  test('erro do provedor não é tratado como cotação', () async {
    final client = MockClient((_) async => http.Response('{}', 503));
    addTearDown(client.close);
    await expectLater(RatesRepository(client: client, apiKey: 'test').fetch(),
        throwsStateError);
  });
}
