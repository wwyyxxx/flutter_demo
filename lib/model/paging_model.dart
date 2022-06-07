//通用分页Model
class PagingModel<T> {
  String? nextPageUrl;
  late List<T> itemList;
}
