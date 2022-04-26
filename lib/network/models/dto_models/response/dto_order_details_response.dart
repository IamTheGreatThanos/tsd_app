class DTOOrderDetails {
  final String? id;
  final String? orderName;
  final int? containerCount;
  final DateTime? createdAt;
  final String? stockName;
  final bool isActive;

  DTOOrderDetails({
    this.id,
    this.orderName,
    this.containerCount,
    this.createdAt,
    this.stockName,
    this.isActive = true,
  });
}
