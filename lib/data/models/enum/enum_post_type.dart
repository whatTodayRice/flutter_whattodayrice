enum PostType {
  free("자유"),
  question("질문"),
  secondHand("중고 거래"),
  none("");

  final String title;

  const PostType(this.title);

  static PostType fromString(String postType) {
    switch (postType) {
      case "free":
        return PostType.free;
      case "question":
        return PostType.question;
      case "trade":
        return PostType.secondHand;
      default:
        return PostType.none;
    }
  }
}
