enum TradeStatus {
  selling("판매중"),
  reserved("예약중"),
  sold("판매 완료"),
  none("");

  final String title;

  const TradeStatus(this.title);

  static fromString(String tradeType) {
    switch (tradeType) {
      case "selling":
        return TradeStatus.selling;
      case "reserved":
        return TradeStatus.reserved;
      case "sold":
        return TradeStatus.sold;
      default:
        return TradeStatus.none;
    }
  }
}
