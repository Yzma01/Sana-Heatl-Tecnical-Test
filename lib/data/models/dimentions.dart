class Dimensions {
  double depth;
  double width;
  double height;

  Dimensions({required this.depth, required this.width, required this.height});

  factory Dimensions.empty() {
    return Dimensions(depth: 0.0, width: 0.0, height: 0.0);
  }

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      depth: (json['depth'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'depth': depth, 'width': width, 'height': height};
  }
}
