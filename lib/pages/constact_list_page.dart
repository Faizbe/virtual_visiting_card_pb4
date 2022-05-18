import 'package:flutter/material.dart';
import 'package:virtual_visiting_card_pb4/customwidgets/contact_item.dart';
import 'package:virtual_visiting_card_pb4/db/sqlite_helper.dart';
import 'package:virtual_visiting_card_pb4/model/contact_model.dart';
import 'package:virtual_visiting_card_pb4/pages/new_contact_page.dart';

class ContactListPage extends StatefulWidget {
  static const String routeName = '/contact_list';

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<ContactModel> _contactList = [];
  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() {
    print('getData called');
    DBHelper.getAllContacts().then((cList) {
      setState(() {
        _contactList = cList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _contactList.length,
        itemBuilder: (context, index) {
          final contact = _contactList[index];
          return ContactItem(contact, _getData);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ContactModel? contact = await Navigator.pushNamed(context, NewContactPage.routeName) as ContactModel;
          if(contact != null) {
            setState(() {
              _contactList.add(contact);
            });
          }
        },
        child: Icon(Icons.add),
        tooltip: 'Add a new Contact',
      ),
    );
  }
}
