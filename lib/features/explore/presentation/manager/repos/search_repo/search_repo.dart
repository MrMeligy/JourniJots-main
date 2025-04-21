import 'package:dartz/dartz.dart';
import 'package:journijots/features/explore/data/search_model/search_model.dart';

abstract class SearchRepo {
  Future<Either<String, List<SearchModel>>> search(
      {required String text, String? city});
}
