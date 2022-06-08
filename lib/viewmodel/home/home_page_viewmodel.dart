import 'package:fultter/http/http_manger.dart';
import 'package:fultter/model/issue_model.dart';
import 'package:fultter/utils/toast_util.dart';
import 'package:fultter/viewmodel/base_change_notifier.dart';
import 'package:fultter/viewmodel/base_list_viewmodel.dart';
import 'package:fultter/widget/loading_state_widget.dart';

import '../../http/Url.dart';
import '../../model/common_item.dart';

class HomePageViewModel extends BaseListViewModel<Item, IssueEntity> {
  List<Item> bannerList = [];

  @override
  void getData(List<Item> list){
    bannerList = list;
    itemList.clear();
    //为Banner占位，后面要接list列表
    itemList.add(Item());
  }

  @override
  void removeUselessData(List<Item> list) {
    // 移除类型为 'banner2' 的数据
    list.removeWhere((item) {
      return item.type == 'banner2';
    });
  }

  @override
  IssueEntity getModel(Map<String, dynamic> json) => IssueEntity.fromJson(json);

  @override
  String getUrl() {
    return Url.feedUrl;
  }

  @override
  void doExtraAfterRefresh() async {
    // 此处调用加载更多，是为了获取首次列表数据，因为第一个列表数据用来做banner数据了。
    await loadMore();
  }

}
