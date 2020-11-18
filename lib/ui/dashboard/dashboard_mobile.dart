import 'dart:async';

import 'package:flutter/material.dart';
import 'package:monitor_orgadmin/ui/users/user_list_main.dart';
import 'package:monitorlibrary/bloc/monitor_bloc.dart';
import 'package:monitorlibrary/bloc/theme_bloc.dart';
import 'package:monitorlibrary/data/photo.dart';
import 'package:monitorlibrary/data/project.dart';
import 'package:monitorlibrary/data/user.dart';
import 'package:monitorlibrary/functions.dart';
import 'package:monitorlibrary/ui/project_list/project_list_main.dart';
import 'package:page_transition/page_transition.dart';

class DashboardMobile extends StatefulWidget {
  final User user;

  const DashboardMobile(this.user);
  @override
  _DashboardMobileState createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var _projects = List<Project>();
  var _users = List<User>();
  var _photos = List<Photo>();
  var _videos = List<Video>();

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _setItems();
    _listen();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    projectStreamSubscription.cancel();
    userStreamSubscription.cancel();
    photoStreamSubscription.cancel();
    videoStreamSubscription.cancel();
  }

  var items = List<BottomNavigationBarItem>();
  void _setItems() {
    items.add(BottomNavigationBarItem(
        icon: Icon(Icons.people), label: 'Field Monitors'));
    items.add(
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Projects'));
    items.add(
        BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Reports'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.user.name, style: Styles.whiteSmall),
            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  themeBloc.changeToRandomTheme();
                },
              ),
              IconButton(
                icon: Icon(Icons.location_on),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.map_outlined),
                onPressed: () {},
              ),
            ],
            bottom: PreferredSize(
              child: Column(
                children: [
                  Text(
                    widget.user.organizationName,
                    style: Styles.whiteBoldSmall,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Administrator',
                    style: Styles.blackSmall,
                  ),
                  SizedBox(
                    height: 24,
                  )
                ],
              ),
              preferredSize: Size.fromHeight(100),
            ),
          ),
          backgroundColor: Colors.brown[100],
          bottomNavigationBar: BottomNavigationBar(
            items: items,
            onTap: _handleBottomNav,
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                Container(
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 48,
                        ),
                        Text(
                          '${_projects.length}',
                          style: Styles.blackBoldLarge,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Projects',
                          style: Styles.greyLabelSmall,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: GestureDetector(
                    onTap: _navigateToUserList,
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 48,
                          ),
                          Text(
                            '${_users.length}',
                            style: Styles.blackBoldLarge,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Users',
                            style: Styles.greyLabelSmall,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 48,
                        ),
                        Text(
                          '${_photos.length}',
                          style: Styles.blackBoldLarge,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Photos',
                          style: Styles.greyLabelSmall,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 48,
                        ),
                        Text(
                          '${_videos.length}',
                          style: Styles.blackBoldLarge,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Videos',
                          style: Styles.greyLabelSmall,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _handleBottomNav(int value) {
    switch (value) {
      case 0:
        pp(' 🔆🔆🔆 Navigate to MonitorList');
        _navigateToUserList();
        break;
      case 1:
        pp(' 🔆🔆🔆 Navigate to ProjectList');
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.scale,
                alignment: Alignment.topLeft,
                duration: Duration(seconds: 1),
                child: ProjectListMain(ORG_ADMINISTRATOR)));
        break;
      case 2:
        pp(' 🔆🔆🔆 Navigate to MediaList');
        break;
    }
  }

  void _navigateToUserList() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.topLeft,
            duration: Duration(seconds: 1),
            child: UserListMain()));
  }

  StreamSubscription<List<Project>> projectStreamSubscription;
  StreamSubscription<List<User>> userStreamSubscription;
  StreamSubscription<List<Photo>> photoStreamSubscription;
  StreamSubscription<List<Video>> videoStreamSubscription;

  void _listen() async {
    pp('🔆 🔆 🔆 🔆 Listening to streams from monitorBloc ....');
    projectStreamSubscription = monitorBloc.projectStream.listen((value) {
      pp('🔆 🔆 🔆 Projects from stream controller: 🌽 ${value.length}');
      setState(() {
        _projects = value;
      });
    });
    userStreamSubscription = monitorBloc.usersStream.listen((value) {
      pp('🔆 🔆 🔆 Users from stream controller: 💜 ${value.length}');
      setState(() {
        _users = value;
      });
    });
    photoStreamSubscription = monitorBloc.photoStream.listen((value) {
      pp('🔆 🔆 🔆 Photos from stream controller: 💙 ${value.length}');
      setState(() {
        _photos = value;
      });
    });
    videoStreamSubscription = monitorBloc.videoStream.listen((value) {
      pp('🔆 🔆 🔆 Videos from stream controller: 🏈 ${value.length}');
      setState(() {
        _videos = value;
      });
    });
  }
}
