import 'package:clothing_platform/Model/SalesPostPicture.dart';
import 'package:flutter/material.dart';

import '../../../../Model/Enum/Position.dart';
import '../../../../Model/SalesPost.dart';

class SalesPostListViewListPart extends StatelessWidget {
  final List<SalesPost> salesPostList;
  final void Function(SalesPost, BuildContext) onClickItem;
  SalesPostListViewListPart({Key? key, required this.salesPostList, required this.onClickItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return ListView.builder(
        itemCount: salesPostList.length,
        itemBuilder: (BuildContext buildContext , int index){
            SalesPost current = salesPostList[index];

            late String frontPictUrl = current.pictUrl[0].pictUrl;

            for(SalesPostPicture salesPostPicture in current.pictUrl)
            {
                if(Enum.compareByIndex(salesPostPicture.position, Position.front) == 0){
                    frontPictUrl = salesPostPicture.pictUrl;
                }
            }


            return GestureDetector(
              onTap: (){

                onClickItem(current, context);

              },
              child: SizedBox(
                width: screenWidth,
                height: screenHeight * 0.2,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(

                          flex:3,
                          child:Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(frontPictUrl),
                                    fit:BoxFit.fill
                                ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(screenWidth* 0.02)
                                  )
                              ),
                          )
                      ),
                      spacer(1),
                      Flexible(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 4,

                                child: Text(current.brand.name.toString(), style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1,),
                              ),
                              spacer(1),
                              Flexible(

                                flex:3,
                                child: Text(current.model, textScaleFactor: 0.8,),
                              ),
                              spacer(1),
                              Flexible(
                                flex: 4,

                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(current.price.toInt().toString() + "원", style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.2,),
                                    Expanded(child: Container()),
                                    Text(current.recommendedPrice.toInt().toString()+"원", style: TextStyle(color: Colors.grey), textScaleFactor: 0.9, )
                                  ],
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
            );
        }
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
