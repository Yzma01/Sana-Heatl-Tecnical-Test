import 'dart:io';
import 'package:flutter/foundation.dart';

enum ImageSourceType { local, network }

class ProductImage {
  final String path;
  final ImageSourceType sourceType;
  final String? id;

  ProductImage({required this.path, required this.sourceType, this.id});

  // Constructor para imágenes locales
  factory ProductImage.local(String path, {String? id}) {
    return ProductImage(path: path, sourceType: ImageSourceType.local, id: id);
  }

  // Constructor para imágenes de red
  factory ProductImage.network(String url, {String? id}) {
    return ProductImage(path: url, sourceType: ImageSourceType.network, id: id);
  }

  // Verificar si es local
  bool get isLocal => sourceType == ImageSourceType.local;

  // Verificar si es de red
  bool get isNetwork => sourceType == ImageSourceType.network;

  // Obtener File (solo para imágenes locales)
  File? get file => isLocal ? File(path) : null;

  // Obtener URL (solo para imágenes de red)
  String? get url => isNetwork ? path : null;

  // Serialización
  Map<String, dynamic> toJson() {
    return {'path': path, 'sourceType': sourceType.name, 'id': id};
  }

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      path: json['path'] as String,
      sourceType: ImageSourceType.values.firstWhere(
        (e) => e.name == json['sourceType'],
        orElse: () => ImageSourceType.network,
      ),
      id: json['id'] as String?,
    );
  }

  // Copia con modificaciones
  ProductImage copyWith({
    String? path,
    ImageSourceType? sourceType,
    String? id,
  }) {
    return ProductImage(
      path: path ?? this.path,
      sourceType: sourceType ?? this.sourceType,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'ProductImage(path: $path, sourceType: $sourceType, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductImage &&
        other.path == path &&
        other.sourceType == sourceType &&
        other.id == id;
  }

  @override
  int get hashCode => path.hashCode ^ sourceType.hashCode ^ id.hashCode;
}
