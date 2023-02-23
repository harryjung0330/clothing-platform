import 'package:clothing_platform/Model/SalesPostPicture.dart';
import 'package:clothing_platform/Model/WrapperClass/SalesPostListWrapper.dart';
import 'package:clothing_platform/Repository/TotalRepository.dart';
import 'package:flutter/material.dart';

import '../../../../Model/Enum/Brand.dart';
import '../../../../Model/Enum/Position.dart';
import '../../../../Model/SalesPost.dart';
import 'SalesPostListViewListPart.dart';
import 'package:provider/provider.dart';

class SalesPostListView extends StatefulWidget {
  final void Function(SalesPost, BuildContext) onClickItem;

  SalesPostListView({Key? key, required this.onClickItem}) : super(key: key);

  @override
  State<SalesPostListView> createState() => _SalesPostListViewState();
}

class _SalesPostListViewState extends State<SalesPostListView> {

  late final void Function(SalesPost, BuildContext) onClickItem;
  late SalesPostListWrapper salesPostListWrapper;

  TextEditingController keywordController = TextEditingController();

  TotalRepository totalRepository = TotalRepository();

  @override
  void initState() {
    super.initState();

    print("called initState()");
    onClickItem = widget.onClickItem;



    Future<List<SalesPost>> salesPostListFuture = totalRepository.getSalesPosts();

    salesPostListWrapper = SalesPostListWrapper(salesPosts: salesPostListFuture);
  }


  @override
  Widget build(BuildContext context) {
    print("salesPostListView build is called!");

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;


    return Column(
      children: [
        spacer(2),
        Flexible(
          flex: 6,
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all( Radius.circular(screenWidth * 0.02)),
                border: Border.all(color: Colors.grey)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 6,
                    child: TextField(
                      controller: keywordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "제목 검색",
                      ),
                    ),
                  ),
                  spacer(1),
                  Flexible(
                      flex: 2,
                      child: IconButton(
                        icon: Icon(Icons.search, color: Colors.grey,),
                        onPressed: (){
                          String keyword = keywordController.text;
                          Future<List<SalesPost>> tempFuture = totalRepository.searchPosts(keyword: keyword);

                          salesPostListWrapper.setSalesPosts(salesPosts: tempFuture);

                        },
                      )
                  )
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 40,
          child: ChangeNotifierProvider<SalesPostListWrapper>(
            create: (context){
                return salesPostListWrapper;

              },
            builder: (context, child){

              return FutureBuilder(
                future: context.watch<SalesPostListWrapper>().salesPosts,
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
                  if(snapShot.connectionState == ConnectionState.waiting)
                  {
                    return Center(child: CircularProgressIndicator());
                  }
                  else if(snapShot.connectionState == ConnectionState.done)
                  {
                    if(snapShot.hasError)
                    {
                      print(snapShot.error);
                      print("error has occurred!");
                      return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요."));
                    }
                  }
                  List<SalesPost> data = snapShot.hasData ? snapShot.data: [];


                  return SalesPostListViewListPart(onClickItem: onClickItem, salesPostList: data );
                }
              );

            },
          ),
        ),
      ],
    );
  }

  Widget spacer(int flex)
  {
    return Flexible(

      flex: flex,
      child: Container(),
    );
  }
}
