class TopHeadlinesResponse {
  final String status;
  final int totalResults;
  final List<Article>? articles;

  const TopHeadlinesResponse({
    required this.status,
    required this.totalResults,
    this.articles,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'status': status});
    result.addAll({'totalResults': totalResults});
    result.addAll({'articles': articles?.map((x) => x.toMap()).toList()});

    return result;
  }

  factory TopHeadlinesResponse.fromMap(Map<String, dynamic> map) {
    return TopHeadlinesResponse(
      status: map['status'] ?? '',
      totalResults: map['totalResults']?.toInt() ?? 0,
      articles:
          List<Article>.from(map['articles']?.map((x) => Article.fromMap(x))),
    );
  }
}

class Article {
  final Source? source;
  final String? title;
  final String? author;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  final bool isFavorite;

  const Article({
    this.source,
    this.title,
    this.author,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (source != null) {
      result.addAll({'source': source!.toMap()});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (author != null) {
      result.addAll({'author': author});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (url != null) {
      result.addAll({'url': url});
    }
    if (urlToImage != null) {
      result.addAll({'urlToImage': urlToImage});
    }
    if (publishedAt != null) {
      result.addAll({'publishedAt': publishedAt});
    }
    if (content != null) {
      result.addAll({'content': content});
    }

    return result;
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      source: map['source'] != null ? Source.fromMap(map['source']) : null,
      title: map['title'],
      author: map['author'],
      description: map['description'],
      url: map['url'],
      urlToImage: map['urlToImage'],
      publishedAt: map['publishedAt'],
      content: map['content'],
    );
  }

  Article copyWith({
    Source? source,
    String? title,
    String? author,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
    bool? isFavorite,
  }) {
    return Article(
      source: source ?? this.source,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class Source {
  final String? id;
  final String? name;

  const Source({
    this.id,
    this.name,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }

    return result;
  }

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(
      id: map['id'],
      name: map['name'],
    );
  }
}
