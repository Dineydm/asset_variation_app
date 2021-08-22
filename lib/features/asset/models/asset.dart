class Asset {
  int? day;
  DateTime date;
  double? value;
  double? dayVariation;
  double? firstDayVariation;

  Asset({
    required this.date,
    required this.value,
    this.day,
    this.dayVariation,
    this.firstDayVariation,
  });
}
