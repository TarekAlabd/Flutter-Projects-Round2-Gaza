class TopHeadlinesBody {
  final String country;
  final String? category;
  final List<String>? sources;
  final String? q;
  final int pageSize;
  final int page;

  TopHeadlinesBody({
    required this.country,
    this.category,
    this.sources,
    this.q,
    this.pageSize = 7,
    this.page = 1,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'country': country});
    if(category != null){
      result.addAll({'category': category});
    }
    if(sources != null){
      result.addAll({'sources': sources});
    }
    if(q != null){
      result.addAll({'q': q});
    }
    result.addAll({'pageSize': pageSize});
    result.addAll({'page': page});
  
    return result;
  }
}
