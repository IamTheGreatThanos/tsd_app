class DTOOrderDetails {
  final String? id;
  final String? orderName;
  final int? containerCount;
  final DateTime? createdAt;
  final String? stockName;
  final String? sender;
  final String? addressFrom;
  final String? cityFrom;
  final String? addressTo;
  final String? cityTo;
  final bool isActive;

  DTOOrderDetails({
    this.id,
    this.orderName,
    this.containerCount,
    this.createdAt,
    this.stockName,
    this.sender,
    this.addressFrom,
    this.cityFrom,
    this.addressTo,
    this.cityTo,
    this.isActive = true,
  });
}
