class ExchangeRate<K, V> {
  K from;

  V to;

  double rate;

  double variation;

  ExchangeRate({
    required this.from,
    required this.to,
    required this.rate,
    required this.variation,
  });
}
