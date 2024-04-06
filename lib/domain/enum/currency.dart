enum Currency {
  brl(
    locale: 'pt_BR',
  ),
  usd(
    locale: 'en_US',
  ),
  eur(
    locale: 'de_DE',
  ),
  ars(
    locale: 'es_AR',
  ),
  jpy(
    locale: 'ja_JP',
  ),
  cny(
    locale: 'zh_CN',
  ),
  gbp(
    locale: 'en_GB',
  ),
  cad(
    locale: 'en_CA',
  ),
  aud(
    locale: 'en_AU',
  ),
  btc(
    locale: 'en_US',
  );

  const Currency({
    required this.locale,
  });

  final String locale;

  static Currency fromName(String name) {
    return Currency.values
        .firstWhere((element) => element.name == name.toLowerCase());
  }
}
