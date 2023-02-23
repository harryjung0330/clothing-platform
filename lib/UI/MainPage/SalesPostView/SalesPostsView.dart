import 'package:clothing_platform/Model/WrapperClass/SalesPostWrapper.dart';
import 'package:clothing_platform/UI/MainPage/SalesPostView/SalesPostDetail/SalesPostDetailView.dart';
import 'package:clothing_platform/UI/MainPage/SalesPostView/State/SalesPostViewState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Model/SalesPost.dart';
import 'SalesPostListView/SalesPostListView.dart';

class SalesPostsView extends StatefulWidget {
  const SalesPostsView({Key? key}) : super(key: key);

  @override
  State<SalesPostsView> createState() => _SalesPostsViewState();
}

class _SalesPostsViewState extends State<SalesPostsView> {

  SalesPostViewState salesPostViewState = SalesPostViewState(currentState: SalesPostViewState.SALES_POST_LIST);

  SalesPostWrapper salesPostWrapper = SalesPostWrapper(salesPost: null);

  List<Widget> widgetList = [];

  @override
  void initState() {
    super.initState();

    widgetList.add(SalesPostListView(
      onClickItem: (SalesPost salesPost, BuildContext tempContext){
        print("title of salesPost: " + salesPost.brand.toString());

        SalesPostWrapper salesTempPostWrapper = Provider.of<SalesPostWrapper>(tempContext, listen: false);
        salesTempPostWrapper.setSalesPost(salesPost: salesPost);

        SalesPostViewState temp = Provider.of<SalesPostViewState>(tempContext, listen: false);
        temp.changeState(currentState: SalesPostViewState.SALES_POST_DETAIL);

      },
    ));

    widgetList.add(SalesPostDetailView(
        onClickBackButton:
          (BuildContext tempContext, SalesPost salesPost) {

              SalesPostViewState temp = Provider.of<SalesPostViewState>(tempContext, listen: false);
              temp.changeState(currentState: SalesPostViewState.SALES_POST_LIST);

            }
          )
    );
  }

  @override
  Widget build(BuildContext context) {
    print("salesPostView build is called!");

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SalesPostViewState>(
            create: (context){
              return salesPostViewState;
            }),
        ChangeNotifierProvider<SalesPostWrapper>(create: (context){
          return salesPostWrapper;
        })
      ],
      builder: (context, child){
        return IndexedStack(
          index: context.watch<SalesPostViewState>().currentState,
          children:  widgetList
          /*[
            SalesPostListView(
              onClickItem: (SalesPost salesPost, BuildContext tempContext){
                print("title of salesPost: " + salesPost.title);
                salesPostWrapper.setSalesPost(salesPost: salesPost);
                SalesPostViewState temp = Provider.of<SalesPostViewState>(tempContext, listen: false);
                temp.changeState(currentState: SalesPostViewState.SALES_POST_DETAIL);
              },
            ),
            SalesPostDetailView(salesPostWrapper: salesPostWrapper, onClickBackButton: (BuildContext tempContext, SalesPost salesPost)
                {
                  SalesPostViewState temp = Provider.of<SalesPostViewState>(tempContext, listen: false);
                  temp.changeState(currentState: SalesPostViewState.SALES_POST_LIST);
                },)

          ]
          ,
           */
        );
      },
    );
  }
}


