import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fultter/model/common_item.dart';
import 'package:fultter/state/base_list_state.dart';

import '../../viewmodel/home/home_page_viewmodel.dart';
import '../../widget/home/banner_widget.dart';
import '../../widget/home/list_item_widget.dart';
import '../../widget/loading_state_widget.dart';
import '../../widget/provider_widget.dart';

class HomeBodyPage extends StatefulWidget {
  const HomeBodyPage({Key? key}) : super(key: key);

  @override
  State<HomeBodyPage> createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends BaseListState<Item,HomePageViewModel,HomeBodyPage>{

  _banner(model){
    return Container(
      height: 200,
      padding: EdgeInsets.only(left: 15, top: 15, right: 15),
      // ClipRRect:对子组件进行圆角裁剪
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: BannerWidget(model: model),
      ),
    );
  }

  @override
  Widget getContentChild(HomePageViewModel model) {
    return ListView.separated(itemBuilder: (context,index) {
      if(index == 0) {
        return _banner(model);
      } else {
        if(model.itemList[index].type == 'textHeader') {
          return _titleItem(model.itemList[index]);
        }
        return ListItemWidget(item:model.itemList[index]);
      }
    }, separatorBuilder: (context,index) {
      return Padding(padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Divider(
        height: model.itemList[index].type == "textHeader" || index == 0 ? 0 : 0.5,
        color: model.itemList[index].type == "textHeader" || index == 0 ? Colors.transparent
          : Color(0xffe6e6e6),
      ),);
    }, itemCount: model.itemList.length);
  }

  Widget _titleItem(Item itemList){
    return Container(
      decoration: BoxDecoration(color: Colors.white24),
      padding: EdgeInsets.only(top: 15,bottom: 5),
      child: Center(
        child: Text(itemList.data!.text!,style: TextStyle(
          fontSize: 18,
          color: Colors.black87,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }

  @override
  // TODO: implement viewModel
  HomePageViewModel get viewModel => HomePageViewModel();
}

