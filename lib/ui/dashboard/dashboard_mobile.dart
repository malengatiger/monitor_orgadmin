import 'package:flutter/material.dart';
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                  height: 48,
                )
              ],
            ),
            preferredSize: Size.fromHeight(200),
          ),
        ),
        backgroundColor: Colors.brown[100],
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          onTap: _handleBottomNav,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 48,
                  ),
                  StreamBuilder<List<Project>>(
                      stream: monitorBloc.projectStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          _projects = snapshot.data;
                        }
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            children: [
                              Text(
                                'Number of Projects: ',
                                style: Styles.greyLabelSmall,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                '${_projects.length}',
                                style: Styles.blackBoldMedium,
                              ),
                            ],
                          ),
                        );
                      }),
                  SizedBox(
                    height: 28,
                  ),
                  StreamBuilder<List<User>>(
                      stream: monitorBloc.usersStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          _users = snapshot.data;
                        }
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            children: [
                              Text(
                                'Number of Personnel: ',
                                style: Styles.greyLabelSmall,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                '${_users.length}',
                                style: Styles.blackBoldMedium,
                              ),
                            ],
                          ),
                        );
                      }),
                  SizedBox(
                    height: 28,
                  ),
                  StreamBuilder<List<Photo>>(
                      stream: monitorBloc.photoStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          _photos = snapshot.data;
                        }
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            children: [
                              Text(
                                'Number of Photos: ',
                                style: Styles.greyLabelSmall,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                '${_photos.length}',
                                style: Styles.blackBoldMedium,
                              ),
                            ],
                          ),
                        );
                      }),
                  SizedBox(
                    height: 28,
                  ),
                  StreamBuilder<List<Video>>(
                      stream: monitorBloc.videoStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          _videos = snapshot.data;
                        }
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            children: [
                              Text(
                                'Number of Videos: ',
                                style: Styles.greyLabelSmall,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                '${_videos.length}',
                                style: Styles.blackBoldMedium,
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleBottomNav(int value) {
    switch (value) {
      case 0:
        pp(' 🔆🔆🔆 Navigate to MonitorList');
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
}
