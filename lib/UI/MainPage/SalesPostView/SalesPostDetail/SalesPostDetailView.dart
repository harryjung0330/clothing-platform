import 'package:clothing_platform/Model/WrapperClass/SalesPostWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';

import '../../../../Model/SalesPost.dart';
import '../../../ChattingPage.dart';

class SalesPostDetailView extends StatefulWidget {

  void Function(BuildContext, SalesPost) onClickBackButton;

  SalesPostDetailView({Key? key,  required this.onClickBackButton}) : super(key: key);

  @override
  State<SalesPostDetailView> createState() => _SalesPostDetailViewState();
}

class _SalesPostDetailViewState extends State<SalesPostDetailView> {

  late SalesPostWrapper salesPostWrapper;
  late void Function(BuildContext, SalesPost) onClickBackButton;

  @override
  void initState() {
    super.initState();

    this.onClickBackButton = widget.onClickBackButton;
  }

  @override
  void onDispose(){

  }

  @override
  Widget build(BuildContext context) {
    print("salesPostDetailView build is called!");

    salesPostWrapper = Provider.of<SalesPostWrapper>(context, listen: true);
    SalesPost? salesPost = salesPostWrapper.salesPost;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return salesPost == null? Center(child: CircularProgressIndicator()): Padding(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              scrollViewSpacer(constraint.maxHeight * 0.01, double.infinity),
              SizedBox(
                height: constraint.maxHeight * 0.1 ,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: (){
                      onClickBackButton(context ,salesPost);
                  },
                ),
              ),
              SizedBox(
                height: constraint.maxHeight * 0.88,
                child: LayoutBuilder(
                  builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          scrollViewSpacer(constraint.maxHeight * 0.05, double.infinity),
                          SizedBox(
                            height: constraint.maxHeight * 0.4,
                            width: constraint.maxWidth,
                            child: ImageSlideshow(
                              indicatorColor: Colors.blue,
                              onPageChanged: (value) {
                                debugPrint('Page changed: $value');
                              },
                              autoPlayInterval: 3000,
                              isLoop: true,
                              children: salesPost.pictUrl.map((pictUrl) {
                                return Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(pictUrl.pictUrl),
                                          fit:BoxFit.fill
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(screenWidth* 0.02)
                                      )
                                  ),
                                );
                              }).toList(growable: false),
                            ),
                          ),
                          scrollViewSpacer(constraint.maxHeight * 0.05, double.infinity),
                          Text(salesPost.brand.name.toString(), textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(salesPost.model, textScaleFactor: 0.9,),
                              Expanded(child: Container()),
                              Text(salesPost.price.toInt().toString() + "원", textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold), )
                            ],
                          ),
                          scrollViewSpacer(constraint.maxHeight * 0.05, double.infinity),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: Container()),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("AI 추천 가격", textScaleFactor: 0.7, style: TextStyle(color: Colors.grey),),
                                    Text(salesPost.recommendedPrice.toInt().toString() + "원", textScaleFactor: 1.2, style: TextStyle(color: Colors.grey),),
                                  ],
                                )
                              ],
                            ),
                          scrollViewSpacer(constraint.maxHeight * 0.05, double.infinity),
                          Container(
                            child: Text(salesPost.content),
                          ),
                          scrollViewSpacer(constraint.maxHeight * 0.05, double.infinity),
                          Divider(thickness: constraint.maxHeight * 0.01, color: Theme.of(context).primaryColor),
                          scrollViewSpacer(constraint.maxHeight * 0.02, double.infinity),
                          SizedBox(
                            height: constraint.maxHeight * 0.1,
                            width: constraint.maxWidth,
                            child: Row(
                              children: [
                                IconButton(onPressed: (){},
                                    icon: Icon(Icons.person_pin, size: constraint.maxHeight * 0.08,)
                                ),
                                scrollViewSpacer(double.infinity, constraint.maxWidth * 0.02),
                                Text("싸게파는곰"),
                                Expanded(child: Container()),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      primary: Colors.black,
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(constraint.maxWidth * 0.02)))
                                  ),
                                  child: Text(
                                    "채팅하기", style: TextStyle(color: Colors.white), textScaleFactor: 1,
                                  ),
                                  onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChattingPage()));
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                ),
              )
            ],
          );
        }
      ),
    );
  }

  Widget spacer(int flex)
  {
    return Flexible(

      flex: flex,
      child: Container(),
    );
  }

  Widget scrollViewSpacer(double height, double width)
  {
    return SizedBox(
      width: width,
      height: height,
      child: Container(),
    );
  }


}
