class AssetList {
  final Meta meta;
  final List<int> timestamp;
  final Indicators indicators;

  AssetList(this.meta, this.timestamp, this.indicators);

  static AssetList fromJson(Map<String, dynamic> json) {
    final meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    final timestamp = json['timestamp'].cast<int>();
    final indicators = json['indicators'] != null
        ? Indicators.fromJson(json['indicators'])
        : null;
    return AssetList(meta!, timestamp, indicators!);
  }
}

class Meta {
  final String currency;
  final String symbol;
  final String exchangeName;
  final String instrumentType;
  final int firstTradeDate;
  final int regularMarketTime;
  final int gmtoffset;
  final String timezone;
  final String exchangeTimezoneName;
  final double regularMarketPrice;
  final double chartPreviousClose;
  final double? previousClose;
  final int? scale;
  final int priceHint;
  final CurrentTradingPeriod currentTradingPeriod;
  final String dataGranularity;
  final String range;
  final List<String> validRanges;

  Meta(
      this.currency,
      this.symbol,
      this.exchangeName,
      this.instrumentType,
      this.firstTradeDate,
      this.regularMarketTime,
      this.gmtoffset,
      this.timezone,
      this.exchangeTimezoneName,
      this.regularMarketPrice,
      this.chartPreviousClose,
      this.previousClose,
      this.scale,
      this.priceHint,
      this.currentTradingPeriod,
      this.dataGranularity,
      this.range,
      this.validRanges);

  static Meta fromJson(Map<String, dynamic> json) {
    final currency = json['currency'];
    final symbol = json['symbol'];
    final exchangeName = json['exchangeName'];
    final instrumentType = json['instrumentType'];
    final firstTradeDate = json['firstTradeDate'];
    final regularMarketTime = json['regularMarketTime'];
    final gmtoffset = json['gmtoffset'];
    final timezone = json['timezone'];
    final exchangeTimezoneName = json['exchangeTimezoneName'];
    final regularMarketPrice = json['regularMarketPrice'];
    final chartPreviousClose = json['chartPreviousClose'];
    final previousClose = json['previousClose'];
    final scale = json['scale'];
    final priceHint = json['priceHint'];
    final currentTradingPeriod = json['currentTradingPeriod'] != null
        ? CurrentTradingPeriod.fromJson(json['currentTradingPeriod'])
        : null;
    final dataGranularity = json['dataGranularity'];
    final range = json['range'];
    final validRanges = json['validRanges'].cast<String>();
    return Meta(
        currency,
        symbol,
        exchangeName,
        instrumentType,
        firstTradeDate,
        regularMarketTime,
        gmtoffset,
        timezone,
        exchangeTimezoneName,
        regularMarketPrice,
        chartPreviousClose,
        previousClose,
        scale,
        priceHint,
        currentTradingPeriod!,
        dataGranularity,
        range,
        validRanges);
  }
}

class CurrentTradingPeriod {
  final Pre pre;
  final Pre regular;
  final Pre post;

  CurrentTradingPeriod(this.pre, this.regular, this.post);

  static CurrentTradingPeriod fromJson(Map<String, dynamic> json) {
    final _pre = json['pre'] != null ? Pre.fromJson(json['pre']) : null;
    final _regular =
        json['regular'] != null ? Pre.fromJson(json['regular']) : null;
    final _post = json['post'] != null ? Pre.fromJson(json['post']) : null;
    return CurrentTradingPeriod(_pre!, _regular!, _post!);
  }
}

class Pre {
  final String timezone;
  final int start;
  final int end;
  final int gmtoffset;

  Pre(this.timezone, this.start, this.end, this.gmtoffset);

  static Pre fromJson(Map<String, dynamic> json) {
    final timezone = json['timezone'];
    final start = json['start'];
    final end = json['end'];
    final gmtoffset = json['gmtoffset'];
    return Pre(timezone, start, end, gmtoffset);
  }
}

class TradingPeriods {
  final List<Pre> pre;

  TradingPeriods(this.pre);

  static TradingPeriods fromJson(Map<String, dynamic> json) {
    final _pre;
    if (json['pre'] != null) {
      _pre = json['pre'].map<Pre>((e) => Pre.fromJson(e)).toList();
    } else {
      _pre = null;
    }
    return TradingPeriods(_pre!);
  }
}

class Indicators {
  List<Quote> quote;

  Indicators(this.quote);

  static Indicators fromJson(Map<String, dynamic> json) {
    final _quote = <Quote>[];
    if (json['quote'] != null) {
      json['quote'].forEach((v) {
        _quote.add(Quote.fromJson(v));
      });
    }
    return Indicators(_quote);
  }
}

class Quote {
  final List<double?> open;

  Quote(this.open);

  static Quote fromJson(Map<String, dynamic> json) {
    final open = json['open'].cast<double?>();
    return Quote(open);
  }
}
