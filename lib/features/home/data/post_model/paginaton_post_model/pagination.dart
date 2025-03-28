import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int? totalCount;
  final int? pageSize;
  final int? currentPage;
  final int? totalPages;
  final bool? hasNextPage;
  final bool? hasPreviousPage;

  const Pagination({
    this.totalCount,
    this.pageSize,
    this.currentPage,
    this.totalPages,
    this.hasNextPage,
    this.hasPreviousPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalCount: json['totalCount'] as int?,
        pageSize: json['pageSize'] as int?,
        currentPage: json['currentPage'] as int?,
        totalPages: json['totalPages'] as int?,
        hasNextPage: json['hasNextPage'] as bool?,
        hasPreviousPage: json['hasPreviousPage'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'totalCount': totalCount,
        'pageSize': pageSize,
        'currentPage': currentPage,
        'totalPages': totalPages,
        'hasNextPage': hasNextPage,
        'hasPreviousPage': hasPreviousPage,
      };

  @override
  List<Object?> get props {
    return [
      totalCount,
      pageSize,
      currentPage,
      totalPages,
      hasNextPage,
      hasPreviousPage,
    ];
  }
}
