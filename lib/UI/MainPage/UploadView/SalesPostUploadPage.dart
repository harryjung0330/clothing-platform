import 'package:clothing_platform/Model/Dto/SalesPostCreateDto.dart';
import 'package:clothing_platform/Model/SalesPost.dart';
import 'package:clothing_platform/Repository/TotalRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../../../Model/Enum/Brand.dart';

class SalesPostUploadPage extends StatefulWidget {
  const SalesPostUploadPage({Key? key}) : super(key: key);

  @override
  State<SalesPostUploadPage> createState() => _SalesPostUploadPageState();
}

class _SalesPostUploadPageState extends State<SalesPostUploadPage> {
  SalesPostCreateDto salesPostCreateDto = SalesPostCreateDto();
  TextEditingController contentController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TotalRepository totalRepository = TotalRepository();
  bool isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return MultiProvider(
      providers: [
        Provider(create: (context) => salesPostCreateDto)
    ],
    builder: (context, child){
      return PropertyChangeProvider(
        value: salesPostCreateDto,
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: LayoutBuilder(
              builder: (context, constraint){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    scrollViewSpacer(constraint.maxHeight * 0.01, double.infinity),
                    SizedBox(
                      height: constraint.maxHeight * 0.15 ,
                      width: constraint.maxWidth,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("판매글 생성", textScaleFactor: 1.5,),
                          Expanded(child: Container()),
                          isButtonDisabled? CircularProgressIndicator(): TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: constraint.maxWidth * 0.05),
                                primary: Colors.black,
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(constraint.maxWidth * 0.02)))
                            ),
                            child: Text(
                              "등록하기", style: TextStyle(color: Colors.white), textScaleFactor: 1,
                            ),
                            onPressed: () async {
                              salesPostCreateDto.price = double.tryParse(priceController.text);
                              salesPostCreateDto.content = contentController.text;
                              salesPostCreateDto.brand = Brand.NIKE;

                              salesPostCreateDto.model = "나이키 에어포스1";
                              salesPostCreateDto.recommendedPrice = salesPostCreateDto.price;

                              if(salesPostCreateDto.content == null || salesPostCreateDto.brand ==null || salesPostCreateDto.content == null ||
                                salesPostCreateDto.right == null || salesPostCreateDto.left == null || salesPostCreateDto.front == null ||
                                salesPostCreateDto.back == null || salesPostCreateDto.recommendedPrice == null || salesPostCreateDto.price == null ||
                                salesPostCreateDto.model == null){
                                  showAlertDialog(context, "판매글 작성에 필요한 정보를 채워주세요.", "판매글에 필요한 정보를 다 입력하지 않았습니다.");
                                  return;
                              }

                              if( salesPostCreateDto.price! > salesPostCreateDto.recommendedPrice! * 1.2){
                                showAlertDialog(context, "신발의 가격이 너무 높습니다.", "AI 감평가 금액의 120% 이하까지만 가능합니다.");
                                return;
                              }

                              isButtonDisabled = true;
                              setState((){});

                              bool uploadedSuccess = await totalRepository.uploadeSalesPost(salesPostCreateDto: salesPostCreateDto);

                              isButtonDisabled =false;


                              if(uploadedSuccess)
                                {
                                  showAlertDialog(context, "성공적으로 판매글을 작성했습니다.", "");

                                  salesPostCreateDto.resetAll();
                                  contentController.text="";
                                  priceController.text = "";
                                }
                              else{
                                showAlertDialog(context, "판매글 작성 실패.", "");
                              }

                              setState((){});

                            },
                          )
                        ],
                      ),
                    ),
                    scrollViewSpacer(constraint.maxHeight * 0.001, double.infinity),
                    SizedBox(
                      height: constraint.maxHeight * 0.78,
                      child: LayoutBuilder(builder: (context, constraint){
                        return SingleChildScrollView(
                          child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                            children: [


                              //-------------------------- upper 이미지들
                              SizedBox(
                                height: constraint.maxHeight * 0.4,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:  MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: constraint.maxWidth * 0.45,
                                      child: Column(
                                        children: [
                                          Text("앞모습"),
                                          scrollViewSpacer(constraint.maxHeight * 0.05, double.infinity),
                                          PropertyChangeConsumer<SalesPostCreateDto, Object>(
                                            properties: [SalesPostCreateDto.FRONT],
                                            builder: (context, salesPostCreateDto, properties) {
                                              String? frontPath = salesPostCreateDto == null? null : salesPostCreateDto.front;

                                              return GestureDetector(
                                                onTap: () async {
                                                  String? tempUrl = await _getFromCamera();
                                                  if(tempUrl != null) {
                                                    salesPostCreateDto!.setFront(tempUrl);
                                                  }
                                                },
                                                child: Container(
                                                  height: constraint.maxHeight * 0.3,
                                                  width: constraint.maxWidth * 0.45,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).primaryColor,
                                                    borderRadius: BorderRadius.all(Radius.circular(constraint.maxWidth * 0.05))
                                                  ),
                                                  child: frontPath == null?Center(
                                                    child: SvgPicture.asset("assets/camera.svg", fit: BoxFit.fill,),
                                                  ):Image.file( File(frontPath), fit: BoxFit.fill,)
                                                  ,
                                                ),
                                              );
                                            }
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    SizedBox(
                                      width: constraint.maxWidth * 0.45,
                                      child: Column(
                                        children: [
                                          Text("뒷모습"),
                                          scrollViewSpacer(constraint.maxHeight * 0.05, double.infinity),
                                          PropertyChangeConsumer<SalesPostCreateDto, Object>(
                                              properties: [SalesPostCreateDto.BACK],
                                              builder: (context, salesPostCreateDto, properties) {
                                                String? backPath = salesPostCreateDto == null? null : salesPostCreateDto.back;

                                                return GestureDetector(
                                                  onTap: () async {
                                                    String? tempUrl = await _getFromCamera();
                                                    if(tempUrl != null) {
                                                      salesPostCreateDto!.setBack(tempUrl);
                                                    }
                                                  },
                                                  child: Container(
                                                    height: constraint.maxHeight * 0.3,
                                                      width: constraint.maxWidth * 0.45,
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context).primaryColor,
                                                        borderRadius: BorderRadius.all(Radius.circular(constraint.maxWidth * 0.05))
                                                    ),
                                                    child: backPath == null?Center(
                                                      child: SvgPicture.asset("assets/camera.svg", fit: BoxFit.fill,),
                                                    ):Image.file( File(backPath), fit: BoxFit.fill,)
                                                    ,
                                                  ),
                                                );
                                              }
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              //-------------------------------- upper 이미지들



                              scrollViewSpacer(constraint.maxHeight * 0.02, double.infinity),


                              //----------------------------------- lower 이미지들
                              SizedBox(
                                height: constraint.maxHeight * 0.4,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:  MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: constraint.maxWidth * 0.45,
                                      child: Column(
                                        children: [
                                          Text("왼쪽 모습"),
                                          scrollViewSpacer(constraint.maxHeight * 0.05, double.infinity),
                                          PropertyChangeConsumer<SalesPostCreateDto, Object>(
                                              properties: [SalesPostCreateDto.LEFT],
                                              builder: (context, salesPostCreateDto, properties) {
                                                String? leftPath = salesPostCreateDto == null? null : salesPostCreateDto.left;

                                                return GestureDetector(
                                                  onTap: () async {
                                                    String? tempUrl = await _getFromCamera();
                                                    if(tempUrl != null) {
                                                      salesPostCreateDto!.setLeft(tempUrl);
                                                    }
                                                  },
                                                  child: Container(
                                                    height: constraint.maxHeight * 0.3,
                                                    width: constraint.maxWidth * 0.45,
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context).primaryColor,
                                                        borderRadius: BorderRadius.all(Radius.circular(constraint.maxWidth * 0.05))
                                                    ),
                                                    child: leftPath == null?Center(
                                                      child: SvgPicture.asset("assets/camera.svg", fit: BoxFit.fill,),
                                                    ):Image.file( File(leftPath), fit: BoxFit.fill,)
                                                    ,
                                                  ),
                                                );
                                              }
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    SizedBox(
                                      width: constraint.maxWidth * 0.45,
                                      child: Column(
                                        children: [
                                          Text("오른쪽 모습"),
                                          scrollViewSpacer(constraint.maxHeight * 0.05, double.infinity),
                                          PropertyChangeConsumer<SalesPostCreateDto, Object>(
                                              properties: [SalesPostCreateDto.RIGHT],
                                              builder: (context, salesPostCreateDto, properties) {
                                                String? rightPath = salesPostCreateDto == null? null : salesPostCreateDto.right;

                                                return GestureDetector(
                                                  onTap: () async {
                                                    String? tempUrl = await _getFromCamera();
                                                    if(tempUrl != null) {
                                                      salesPostCreateDto!.setRight(tempUrl);
                                                    }
                                                  },
                                                  child: Container(
                                                    height: constraint.maxHeight * 0.3,
                                                    width: constraint.maxWidth * 0.45,
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context).primaryColor,
                                                        borderRadius: BorderRadius.all(Radius.circular(constraint.maxWidth * 0.05))
                                                    ),
                                                    child: rightPath == null?Center(
                                                      child: SvgPicture.asset("assets/camera.svg", fit: BoxFit.fill,),
                                                    ):Image.file( File(rightPath), fit: BoxFit.fill,)
                                                    ,
                                                  ),
                                                );
                                              }
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              //-------------------------------------- lower 이미지들

                              scrollViewSpacer(constraint.maxHeight * 0.02, double.infinity),

                              SizedBox(
                                height: constraint.maxHeight * 0.1 ,
                                width: constraint.maxWidth,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: constraint.maxWidth * 0.05),
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(constraint.maxWidth * 0.02)))
                                  ),
                                  child: Text(
                                    "AI 분석 받기", style: TextStyle(color: Colors.white), textScaleFactor: 1,
                                  ),
                                  onPressed: (){

                                  },
                                ),
                              ),

                              scrollViewSpacer(constraint.maxHeight * 0.02, double.infinity),

                              Text("물품명"),

                              scrollViewSpacer(constraint.maxHeight * 0.02, double.infinity),

                              PropertyChangeConsumer<SalesPostCreateDto, Object>(
                                properties: [SalesPostCreateDto.MODEL],
                                builder: (context,salesPostCreateDto, properties) {
                                  String? model = salesPostCreateDto == null? null: salesPostCreateDto.model;

                                  return Container(
                                    height: constraint.maxHeight * 0.1,
                                    width: constraint.maxWidth,
                                      decoration:BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.all(Radius.circular(constraint.maxWidth * 0.01))
                                      ),
                                    child: Text(model??"", style: TextStyle(color: Colors.grey),textScaleFactor: 0.9,)
                                  );
                                }
                              ),

                              scrollViewSpacer(constraint.maxHeight * 0.02, double.infinity),

                              Text("AI 감평가"),

                              scrollViewSpacer(constraint.maxHeight * 0.02, double.infinity),

                              PropertyChangeConsumer<SalesPostCreateDto, Object>(
                                  properties: [SalesPostCreateDto.RECOMMENDED_PRICE],
                                  builder: (context,salesPostCreateDto, properties) {
                                    double? recommendedPrice = salesPostCreateDto == null? null: salesPostCreateDto.recommendedPrice;

                                    return Container(
                                        height: constraint.maxHeight * 0.1,
                                        width: constraint.maxWidth,
                                        decoration:BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.all(Radius.circular(constraint.maxWidth * 0.01))
                                        ),
                                        child: Text(recommendedPrice == null? "": recommendedPrice.toInt().toString() + "원", style: TextStyle(color: Colors.grey),textScaleFactor: 1.2,)
                                    );
                                  }
                              ),

                              scrollViewSpacer(constraint.maxHeight * 0.02, double.infinity),

                              Text("가격 입력"),


                              SizedBox(
                                height: constraint.maxHeight * 0.1,
                                width: constraint.maxWidth,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: constraint.maxWidth * 0.7,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: priceController,

                                      ),
                                    ),
                                    Text("원")
                                  ],
                                ),
                              ),
                              scrollViewSpacer(constraint.maxHeight * 0.005, double.infinity),
                              Text("가격은 AI 감정가에서 +20%까지 가능합니다.",style: TextStyle(color: Colors.grey),textScaleFactor: 0.7,),
                              scrollViewSpacer(constraint.maxHeight * 0.02, double.infinity),

                          Text("추가 내용"),

                              scrollViewSpacer(constraint.maxHeight * 0.02, double.infinity),

                          Container(
                              height: constraint.maxHeight * 0.4,
                              width: constraint.maxWidth,
                              decoration:BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.all(Radius.circular(constraint.maxWidth * 0.01))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "내용을 간략하게 입력하세요."
                                ),
                                  controller: contentController,
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null
                              )
                          )
                            ],
                          ),
                        );
                      }),
                    )
                  ],
                );
              }
          ),
        ),
      );
    },);
  }

  Widget scrollViewSpacer(double height, double width)
  {
    return SizedBox(
      width: width,
      height: height,
      child: Container(),
    );
  }

  Future<String?> _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery
    );

    if (pickedFile != null) {
      print(pickedFile.path);
      return pickedFile.path;
    }

    return null;
  }

  showAlertDialog(BuildContext context, String title, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("이전으로"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
