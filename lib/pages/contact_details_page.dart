import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virtual_visiting_card_pb4/db/sqlite_helper.dart';
import 'package:virtual_visiting_card_pb4/model/contact_model.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName = '/contact_details';

  @override
  _ContactDetailsPageState createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  ContactModel? _contactModel;
  int? _id;
  late String _name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    _id = argList[0];
    _name = argList[1];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_name),
      ),
      body: Center(
        child: FutureBuilder<ContactModel>(
          future: DBHelper.getContactById(_id!),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              _contactModel = snapshot.data;
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                children: [
                  ListTile(
                    title: Text(_contactModel!.designation!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_contactModel!.companyName!),
                        Text(_contactModel!.streetAddress!),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(_contactModel!.mobileNumber),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.sms),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.call),
                                  onPressed: _makePhoneCall,
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            title: Text(_contactModel!.emailAddress!),
                            trailing: IconButton(
                              icon: Icon(Icons.email),
                              onPressed: () {},
                            ),
                          ),
                          ListTile(
                            title: Text(_contactModel!.streetAddress!),
                            trailing: IconButton(
                              icon: Icon(Icons.map),
                              onPressed: _showMap,
                            ),
                          ),
                          ListTile(
                            title: Text(_contactModel!.website!),
                            trailing: IconButton(
                              icon: Icon(Icons.web),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            if(snapshot.hasError) {
              return const Text('Failed to fetch data');
            }
            return const CircularProgressIndicator();
          },
        ),
      )
    );
  }

  void _makePhoneCall() async {
    final url = 'tel:${_contactModel!.mobileNumber}';
    if(await canLaunch(url)) {
      await launch(url);
    }else {
      throw 'Could not launch application';
    }
  }

  void _showMap() async {

    final url = Platform.isAndroid ? 'geo:0,0?q=${_contactModel!.streetAddress}' :
    '';
    if(await canLaunch(url)) {
    await launch(url);
    }else {
    throw 'Could not launch application';
    }
  }
}
