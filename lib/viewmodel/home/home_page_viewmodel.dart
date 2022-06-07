import 'package:fultter/http/http_manger.dart';
import 'package:fultter/model/issue_model.dart';
import 'package:fultter/utils/toast_util.dart';
import 'package:fultter/viewmodel/base_change_notifier.dart';
import 'package:fultter/widget/loading_state_widget.dart';

import '../../http/Url.dart';
import '../../model/common_item.dart';

class HomePageViewModel extends BaseChangeNotifier {
  List<Item> bannerList = [];

  void refresh() {
    HttpManager.getData(
      Url.feedUrl,
      success: (json) {
        IssueEntity model = IssueEntity.fromJson(json);
        bannerList = model.itemList;
        bannerList.removeWhere((element) => element.type == 'banner2');
        viewState = ViewState.done;
      },
      fail: (e) {
        WyxToast.showError(e.toString());
      },
      complete: () => notifyListeners(),
    );
  }

  retry() {
    viewState = ViewState.loading;
    notifyListeners();
    refresh();
  }
}
