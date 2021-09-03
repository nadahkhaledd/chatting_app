import 'package:chatting_app/Rooms/AddRooms.dart';
import 'package:chatting_app/Rooms/browseroom.dart';
import 'package:chatting_app/Rooms/myrooms.dart';
import 'package:chatting_app/componants/componants.dart';
import 'package:chatting_app/tools/AppProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../Database/User.dart';
import 'SideMenu.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppProvider provider;
  List<Tab> screensTabs = [
    Tab(text: "MyRooms"),
    Tab(text: "Browse"),
  ];
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    List<Widget> screens = [
      myroom(),
      BrowseRoom(),
    ];

    return DefaultTabController(
    length: screensTabs.length,
    child: Builder(builder: (BuildContext context) {
      final TabController tabController = DefaultTabController.of(context)!;
      tabController.addListener(() {
        if (!tabController.indexIsChanging) {
        }
      });
      return Stack(
        children:[
          Container(color: Colors.white),
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill)),
        ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(

              bottom: TabBar(
                tabs:screensTabs,
              ),
              title: Text(
      AppLocalizations.of(context)!.appTitle,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    CupertinoIcons.search,
                    //Icons.search,
                    color: Colors.white,
                    size: 32.0,
                  ),
                  onPressed: () {},
                )
              ],

            ),
            drawer: SideMenu(),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        navigateTo(context, AddRooms());
      },
      child: Icon(Icons.add),
      ),
      body: TabBarView(
      children: screens,
      ),
      )
        ]

      );

    }),
  );
  }
}