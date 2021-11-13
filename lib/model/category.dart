class Category {
  int categoryId;
  String categoryName;
  String categoryDec;
  int parent;
  Image image;

  Category({
    this.categoryId,
    this.categoryName,
    this.categoryDec,
    this.image,
  });

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['id'];
    categoryName = json['name'];
    categoryDec = json['description'];
    parent = json['parent'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }
}

class Image {
  String url;

  Image({
    this.url,
  });

  Image.fromJson(Map<String, dynamic> json) {
    url = json['src'];
  }
}
