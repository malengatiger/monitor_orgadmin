import 'package:flutter/material.dart';
import 'package:monitor_orgadmin/ui/dashboard/dashboard_desktop.dart';
import 'package:monitor_orgadmin/ui/dashboard/dashboard_mobile.dart';
import 'package:monitor_orgadmin/ui/dashboard/dashboard_tablet.dart';
import 'package:monitorlibrary/api/sharedprefs.dart';
import 'package:monitorlibrary/auth/app_auth.dart';
import 'package:monitorlibrary/bloc/monitor_bloc.dart';
import 'package:monitorlibrary/data/user.dart';
import 'package:monitorlibrary/functions.dart';
import 'package:monitorlibrary/ui/signin.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DashboardMain extends StatefulWidget {
  DashboardMain({Key key}) : super(key: key);

  @override
  _DashboardMainState createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  var isBusy = false;
  User user;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  void _checkUser() async {
    setState(() {
      isBusy = true;
    });
    pp('🔐 🔐 🔐 🔐 ... Checking user ......');
    var signeIn = await AppAuth.isUserSignedIn();
    pp('ProjectList: 🥦🥦 is user signed in? $signeIn : 🔐 if false, go sign in ...');
    if (!signeIn) {
      var result = await Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.scale,
              alignment: Alignment.topLeft,
              duration: Duration(seconds: 1),
              child: SignIn(ORG_ADMINISTRATOR)));
      if (result != null) {
        if (result is User) {
          user = result;
          _getData();
        }
        setState(() {
          isBusy = false;
        });
      }
    } else {
      user = await Prefs.getUser();
      _getData();
    }
  }

  void _getData() {
    setState(() {
      isBusy = true;
    });
    monitorBloc.getOrganizationProjects(organizationId: user.organizationId);
    monitorBloc.getOrganizationUsers(organizationId: user.organizationId);
    monitorBloc.getOrganizationPhotos(organizationId: user.organizationId);
    monitorBloc.getOrganizationVideos(organizationId: user.organizationId);
    setState(() {
      isBusy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isBusy
        ? Center(
            child: Container(
              child: CircularProgressIndicator(
                strokeWidth: 8,
                backgroundColor: Colors.black,
              ),
            ),
          )
        : ScreenTypeLayout(
            mobile: DashboardMobile(user),
            tablet: DashboardTablet(user),
            desktop: DashboardDesktop(user),
          );
  }
}
