import 'package:clothing_platform/Model/Dto/LogInRequestDto.dart';
import 'package:clothing_platform/Model/Dto/LogInResponseDto.dart';
import 'package:clothing_platform/Repository/TotalRepository.dart';
import 'package:clothing_platform/UI/MainPage/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController psController = TextEditingController();

  TotalRepository totalRepository = TotalRepository();


  @override
  void dispose()
  {
    print("dispose called!");

    emailController.dispose();
    psController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return safteyBackground(
       getMainWidget(context, screenHeight, screenWidth),
        screenHeight,
        screenWidth
    );
  }

  Widget getMainWidget(BuildContext context,double screenHeight, double screenWidth )
  {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.1, horizontal: screenWidth * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 9,
              child: Center(
                child:  SvgPicture.asset(
                    "assets/logo.svg",
                    fit: BoxFit.fill),
              ),
          )
          ,
          Flexible(
            flex: 1,
              child: Text(
                "이메일 주소"
              )
          ),
          spacer(1),
          Flexible(
            flex: 2,
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "이메일을 입력하세요",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          spacer(2),
          Flexible(
              flex: 1,
              child: Text(
                  "비밀번호"
              )
          ),
          spacer(1),
          Flexible(
            flex: 2,
            child: TextField(
              obscureText: true,
              controller: psController,
              decoration: InputDecoration(
                hintText: "비밀번호를 입력하세요",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          spacer(2),
          Flexible(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(screenHeight * 0.05)))
                ),
                child: Text(
                  "로그인", style: TextStyle(color: Colors.white), textScaleFactor: 1.2,
                ),
                onPressed: () async {
                  String email = emailController.text;
                  String password = psController.text;

                  LogInRequestDto logInRequestDto = LogInRequestDto(email: email, password: password);

                  bool result = await totalRepository.logIn(logInRequestDto);

                  if(result)
                  {

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainPage()));

                  }

                  print("logInResult: " + result.toString());

                },
              ),
            ),
          ),
          spacer(1),
          Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: 0, bottom: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                      },
                      child: Text(
                        "회원가입"
                      ),
                    ),
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: (){
                      },
                      child: Text(
                          "비밀번호 찾기"
                      ),
                    ),

                  ],
                ),
              )
          ),
          spacer(2)
        ],
      ),
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
