enum EnergyType {
  solar("solar"),
  house('house'),
  battery('battery');

  final String queryParam;

  const EnergyType(this.queryParam);
}
