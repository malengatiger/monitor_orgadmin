import 'package:flutter/material.dart';
import 'package:monitorlibrary/data/user.dart';
import 'package:monitorlibrary/functions.dart';

class UserEditMobile extends StatefulWidget {
  final User user;
  const UserEditMobile(this.user);

  @override
  _UserEditMobileState createState() => _UserEditMobileState();
}

class _UserEditMobileState extends State<UserEditMobile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cellphoneController = TextEditingController();

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _setup();
  }

  void _setup() {
    if (widget.user != null) {
      nameController.text = widget.user.name;
      emailController.text = widget.user.email;
      cellphoneController.text = widget.user.cellphone;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() async {
    pp('😡 😡 😡 _submit ......... ');
    if (widget.user == null) {
    } else {}
  }

  int userType = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'User Editor',
            style: Styles.whiteSmall,
          ),
          bottom: PreferredSize(
            child: Column(
              children: [
                Text(
                  widget.user == null ? 'New User' : 'Edit User',
                  style: Styles.blackBoldMedium,
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
            preferredSize: Size.fromHeight(100),
          ),
        ),
        backgroundColor: Colors.brown[100],
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Name',
                          hintText: 'Enter Full Name'),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          icon: Icon(Icons.email_outlined),
                          labelText: 'Email Address',
                          hintText: 'Enter Email Address'),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    TextFormField(
                      controller: cellphoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          icon: Icon(Icons.phone),
                          labelText: 'Cellphone',
                          hintText: 'Cellphone'),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    widget.user == null
                        ? TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            decoration: InputDecoration(
                                icon: Icon(Icons.person),
                                labelText: 'Password',
                                hintText: 'Password'),
                          )
                        : Container(),
                    SizedBox(
                      height: 12,
                    ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       'Select User Type Below:',
                    //       style: Styles.blackBoldSmall,
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 4,
                    // ),
                    // DropdownButton(
                    //   onChanged: (value) {
                    //     userType = value;
                    //   },
                    //   items: [
                    //     DropdownMenuItem(
                    //       child: Text(''),
                    //     ),
                    //     DropdownMenuItem(
                    //       child: Text(FIELD_MONITOR),
                    //     ),
                    //     DropdownMenuItem(
                    //       child: Text(ORG_ADMINISTRATOR),
                    //     ),
                    //     DropdownMenuItem(
                    //       child: Text(ORG_EXECUTIVE),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: userType,
                          onChanged: _handleRadioValueChange,
                        ),
                        Text(
                          'Monitor',
                          style: Styles.blackTiny,
                        ),
                        Radio(
                          value: 1,
                          groupValue: userType,
                          onChanged: _handleRadioValueChange,
                        ),
                        Text('Admin', style: Styles.blackTiny),
                        Radio(
                          value: 2,
                          groupValue: userType,
                          onChanged: _handleRadioValueChange,
                        ),
                        Text(
                          'Executive',
                          style: Styles.blackTiny,
                        ),
                      ],
                    ),
                    Text(type == null ? '' : type),
                    SizedBox(
                      height: 16,
                    ),
                    RaisedButton(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Submit',
                          style: Styles.whiteSmall,
                        ),
                      ),
                      onPressed: _submit,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String type;
  void _handleRadioValueChange(Object value) {
    pp('🌸 🌸 🌸 🌸 🌸 _handleRadioValueChange: 🌸 $value');
    setState(() {
      switch (value) {
        case 0:
          type = FIELD_MONITOR;
          userType = 0;
          break;
        case 1:
          type = ORG_ADMINISTRATOR;
          userType = 1;
          break;
        case 2:
          type = ORG_EXECUTIVE;
          userType = 2;
          break;
      }
    });
  }
}
