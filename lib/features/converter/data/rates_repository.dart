import 'dart:convert';
import 'package:http/http.dart' as http;

enum Currency { real, dollar, euro }

class ExchangeRates {
  final double dollar;
  final double euro;
  ExchangeRates({required this.dollar, required this.euro}) {
    if (!dollar.isFinite || !euro.isFinite || dollar <= 0 || euro <= 0) {
      throw const FormatException('Cotação inválida.');
    }
  }
  factory ExchangeRates.fromJson(Map<String, dynamic> body) {
    final currencies = body['results']?['currencies'];
    final dollar = currencies?['USD']?['buy'];
    final euro = currencies?['EUR']?['buy'];
    if (dollar is! num || euro is! num)
      throw const FormatException('Cotações ausentes.');
    return ExchangeRates(dollar: dollar.toDouble(), euro: euro.toDouble());
  }
  double _rate(Currency currency) => switch (currency) {
        Currency.real => 1,
        Currency.dollar => dollar,
        Currency.euro => euro,
      };
  double convert(double amount, Currency from, Currency to) {
    if (!amount.isFinite) throw ArgumentError.value(amount, 'amount');
    return amount * _rate(from) / _rate(to);
  }
}

class RatesRepository {
  final http.Client _client;
  final bool _ownsClient;
  final String apiKey;
  RatesRepository(
      {http.Client? client,
      this.apiKey = const String.fromEnvironment('HGBRASIL_API_KEY')})
      : _client = client ?? http.Client(),
        _ownsClient = client == null;
  Future<ExchangeRates> fetch() async {
    if (apiKey.isEmpty) throw StateError('Configure HGBRASIL_API_KEY.');
    final response = await _client.get(Uri.https(
        'api.hgbrasil.com', '/finance', {'format': 'json', 'key': apiKey}));
    if (response.statusCode != 200)
      throw StateError('Falha ao consultar cotações (${response.statusCode}).');
    final body = jsonDecode(response.body);
    if (body is! Map<String, dynamic>)
      throw const FormatException('Resposta inválida.');
    return ExchangeRates.fromJson(body);
  }

  void close() {
    if (_ownsClient) _client.close();
  }
}
