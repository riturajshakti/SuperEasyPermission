import 'package:flutter/material.dart';
import 'package:super_easy_permissions/super_easy_permissions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _filePermission = 'Not Enabled';

  @override
  void initState() {
    super.initState();

    // Checking if file permission is already granted
    SuperEasyPermissions.isGranted(Permissions.camera).then((result) {
      if (result) {
        setState(() => _filePermission = 'Granted !');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Super Easy Permission example'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('File Permission: $_filePermission'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  // Checking if file permission is granted
                  bool result =
                      await SuperEasyPermissions.isGranted(Permissions.camera);
                  if (result) {
                    setState(() => _filePermission = 'Granted !');
                  }
                },
                child: Text('Check Permission'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  // requesting permission
                  bool result = await SuperEasyPermissions.askPermission(
                      Permissions.camera);
                  if (result) {
                    setState(() => _filePermission = 'Granted !');
                  }
                },
                child: Text('Ask Permission'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  // Checking if file permission is permanently denied
                  bool result = await SuperEasyPermissions.isPermanentlyDenied(
                      Permissions.camera);
                  if (result) {
                    setState(() => _filePermission = 'Permanently denied !');
                  }
                },
                child: Text('Check if Permanently Denied'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
