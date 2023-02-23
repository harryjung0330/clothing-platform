import 'package:flutter/material.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage({Key? key}) : super(key: key);

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    return safteyBackground(getMainWidget(context, screenHeight, screenWidth), screenHeight, screenWidth);
  }

  Widget getMainWidget(BuildContext context, double screenHeight, double screenWidth)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: screenHeight * 0.02,
          child: Container(),
        ),

        IconButton(
            onPressed: (){
                Navigator.pop(context);
            },
            icon: Icon(Icons.navigate_before, size: screenWidth * 0.1,)
        ),
        SizedBox(
          height: screenHeight * 0.01,
          child: Container(),
        ),
        Divider(color: Colors.grey,),
        Expanded(child: Container()),
        Divider(color: Colors.grey,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.add, )),
            SizedBox(width: screenWidth * 0.02,),
            SizedBox(
              width: screenWidth * 0.4,
              child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "채팅을 입력하세요.",
                  )
              ),
            ),
            Expanded(child: Container()),
            TextButton(
                onPressed: (){},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: screenWidth * 0.02),
                  backgroundColor: Colors.red,
                  ),
                child: Text(
                  "전송하기", style: TextStyle(color: Colors.white), textScaleFactor: 1,
                )
            ),
            SizedBox(
              width: screenWidth * 0.03,
              child: Container(),
            )
          ],
        )
      ],
    );
  }

  Widget safteyBackground(Widget mainWidget, double screenHeight, double screenWidth)
  {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          body: SingleChildScrollView(
              child:SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                  child: mainWidget
              )
          )
      ),
    );
  }

  Widget spacer(int flex)
  {
    return Flexible(
      flex: flex,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
