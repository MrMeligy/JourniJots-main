import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journijots/features/explore/data/search_model/search_model.dart';
import 'package:journijots/features/explore/presentation/manager/repos/search_repo/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());
  final SearchRepo searchRepo;
  search({required String text, String? city}) async {
    emit(SearchLoading());
    final response = await searchRepo.search(
      text: text,
      city: city,
    );
    response.fold(
      (err) => emit(
        SearchFailure(errMessage: err),
      ),
      (results) => emit(
        SearchSuccess(results: results),
      ),
    );
  }
}
