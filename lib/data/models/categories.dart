class Categories {
  String slug;
  String name;
  String url;

  Categories({required this.name, required this.slug, required this.url});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      name: (json['name']),
      slug: (json['slug']),
      url: (json['url']),
    );
  }
}
