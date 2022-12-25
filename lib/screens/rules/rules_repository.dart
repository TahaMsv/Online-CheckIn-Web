import 'data_source/rules_remote_ds.dart';
import 'interfaces/rules_repository_interface.dart';

class RulesRepository implements RulesRepositoryInterface {
  final RulesRemoteDataSource rulesRemoteDataSource;

  RulesRepository({required this.rulesRemoteDataSource});
}