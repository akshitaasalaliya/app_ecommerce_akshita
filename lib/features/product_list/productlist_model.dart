import 'dart:convert';
import '../../core/constants/RepositoryConstants.dart';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final List image;
  final double price;
  final int stock;
  final String category;
  final double rating;
  int quantity;
  bool isFavorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.stock,
    required this.category,
    this.rating = 0.0,
    this.quantity = 0,
    this.isFavorite = false,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    List? image,
    double? price,
    int? stock,
    String? category,
    double? rating,
    int? quantity,
    bool? isFavorite,
  }){
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      quantity: quantity ?? this.quantity,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
        id: json[RepositoryConstants.id] ?? 0,
        name: json[RepositoryConstants.title] ?? '',
        description: json[RepositoryConstants.description] ?? '',
        image: json[RepositoryConstants.images] ?? [],
        price: (json[RepositoryConstants.price] as num?)?.toDouble() ?? 0.0,
        stock: json[RepositoryConstants.stock] ?? 0,
        category: json[RepositoryConstants.category] ?? '',
        rating: (json[RepositoryConstants.rating] as num?)?.toDouble() ?? 0.0,
        quantity: json[RepositoryConstants.minimumOrderQuantity] ?? 1,
    );
  }

  static List<ProductModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((e) => ProductModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': jsonEncode(image),
      'price': price,
      'stock': stock,
      'category': category,
      'rating': rating,
      'quantity': quantity,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] != null ? jsonDecode(map['image']) : [],
      price: map['price'] ?? 0.0,
      stock: map['stock'] ?? 0,
      category: map['category'] ?? '',
      rating: map['rating'] ?? 0.0,
      quantity: map['quantity'] ?? 1,
      isFavorite: map['isFavorite'] == 1,
    );
  }
}
