import 'package:clothing_platform/UI/MainPage/SalesPostView/SalesPostsView.dart';
import 'package:clothing_platform/UI/MainPage/UploadView/SalesPostUploadPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {

  late TabController _tabController;
  List<Widget> tabWidgets = [];

  @override
  void initState() {
    super.initState();

    tabWidgets.add(SalesPostsView());

    tabWidgets.add(SalesPostUploadPage());

    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return safteyBackground(getMainWidget(screenHeight, screenWidth), screenHeight, screenWidth);
  }
  
  Widget getMainWidget(double screenHeight, double screenWidth)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 25,
          child: TabBarView(
            controller: _tabController,
              children: tabWidgets
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
            flex:1,
            child: Divider(color: Colors.black, height: 0.01,)
        ),
        Flexible(
          fit: FlexFit.tight,
          flex:2,
          child: TabBar(
            indicatorColor: Colors.transparent,
            controller: _tabController,
              tabs: [
                Tab(
                  icon: SvgPicture.asset(
                      "assets/home_icon.svg",
                      fit: BoxFit.fill),
                ),
                Tab(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: screenHeight * 0.06
                  )
                )
              ]
          ),
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
            child: SizedBox(
                height: screenHeight,
                width: screenWidth,
                child: mainWidget
            ),
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
