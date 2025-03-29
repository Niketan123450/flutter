abstract class UseCase<Type, params> {
  Future<Type> call({params params});
}
