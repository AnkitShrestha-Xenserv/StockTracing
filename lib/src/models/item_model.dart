class ItemModel {
  final String companyName;
  final int noOfTransactions;
  final double maxPrice;
  final double minPrice;
  final double closingPrice;
  final int tradedShares;
  final double amount;
  final double previousClosing;
  final double difference;

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : companyName = parsedJson['companyName'],
        noOfTransactions = parsedJson['noOfTransactions'] ?? 0,
        maxPrice = parsedJson['maxPrice'] ?? 0.0,
        minPrice = parsedJson['minPrice'] ?? 0.0,
        closingPrice = parsedJson['closingPrice'] ?? 0.0,
        tradedShares = parsedJson['tradedShares'] ?? 0,
        amount = parsedJson['amount'] ?? 0.0,
        previousClosing = parsedJson['previousClosing'] ?? 0.0,
        difference = parsedJson['difference'] ?? 0.0;

  ItemModel.fromDb(Map<String, dynamic> parsedJson)
      : companyName = parsedJson['companyName'] as String,
        noOfTransactions = parsedJson['noOfTransactions'] as int,
        maxPrice = (parsedJson['maxPrice'] as double),
        minPrice = (parsedJson['minPrice'] as double),
        closingPrice = (parsedJson['closingPrice'] as double),
        tradedShares = parsedJson['tradedShares'] as int,
        amount = (parsedJson['amount'] as double),
        previousClosing = (parsedJson['previousClosing'] as double),
        difference = (parsedJson['difference'] as double);

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      "companyName": companyName,
      "noOfTransactions": noOfTransactions,
      "maxPrice": maxPrice,
      "minPrice": minPrice,
      "closingPrice": closingPrice,
      "tradedShares": tradedShares,
      "amount": amount,
      "previousClosing": previousClosing,
      "difference": difference
    };
  }

  @override
  String toString() =>
      'CompanyName: $companyName \n NoOfTransactions: $noOfTransactions \n' +
      ' MaxPrice: $maxPrice \n MinPrice: $minPrice \n ClosingPrice: $closingPrice \n' +
      ' TradedShares: $tradedShares \n Amount: $amount \n PreviousClosingPrice: $previousClosing \n' +
      ' Difference: $difference \n';
}
