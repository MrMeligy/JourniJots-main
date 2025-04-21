import 'package:dartz/dartz.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/features/explore/data/search_model/search_model.dart';
import 'package:journijots/features/explore/presentation/manager/repos/search_repo/search_repo.dart';

class SearchRepoImpl extends SearchRepo {
  final ApiConsumer api;

  SearchRepoImpl({required this.api});
  @override
  Future<Either<String, List<SearchModel>>> search(
      {required String text, String? city}) async {
    try {
      var response = await api.get(
        EndPoint.search(text: text, city: city),
      );
      final List<SearchModel> results =
          (response as List).map((item) => SearchModel.fromJson(item)).toList();
      return (right(results));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }
}
