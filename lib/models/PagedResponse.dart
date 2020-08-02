import 'package:flutter_app/models/carDTO.dart';

class PagedResponse<T>{
  final int totalItems;
  final int startItems;
  final int itemsPerPage;
  final int currentPage;
  final int totalPages;
  final List<T> results;
  final String code;
  final String shortDescription;
  final T object;

  PagedResponse({
    this.totalItems,
    this.startItems,
    this.itemsPerPage,
    this.currentPage,
    this.totalPages,
    this.results,
    this.code,
    this.shortDescription,
    this.object,
});

  factory PagedResponse.fromJson(Map<String, dynamic> json) {
    final startItems = json['startItems'].cast<Map<int, dynamic>>();
    final totalItems = json['totalItems'].cast<Map<int, dynamic>>();
    final itemsPerPage = json['itemsPerPage'].cast<Map<int, dynamic>>();
    final currentPage = json['currentPage'].cast<Map<int, dynamic>>();
    final totalPages = json['totalPages'].cast<Map<int, dynamic>>();
    final results = json['results'].cast<Map<List<T>, dynamic>>();
    final object = json['object'].cast<Map<T, dynamic>>();
    final code = json['code'].cast<Map<String, dynamic>>();
    final shortDescription = json['shortDescription'].cast<Map<String, dynamic>>();

    return PagedResponse<T>(
        totalItems: totalItems,
        totalPages: totalPages,
        currentPage: currentPage,
        startItems: startItems,
        itemsPerPage: itemsPerPage,
        results: results,
        code: code,
        shortDescription: shortDescription,
        object: object
    );
  }
}