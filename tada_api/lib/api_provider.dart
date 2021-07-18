abstract class ApiProvider<Param, Result> {
  Future<Result> execute([Param param]);
}
