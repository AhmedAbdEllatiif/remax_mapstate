class PageInfo {
  final int limit;
  final int offset;
  final String orderBy;

  PageInfo({this.limit = 50, this.offset = 0, this.orderBy = ""});

  Map<String, dynamic> toJson() {
    return {
      "limit": limit,
      "offset": offset,
      "orderBy": orderBy,
    };
  }
}
