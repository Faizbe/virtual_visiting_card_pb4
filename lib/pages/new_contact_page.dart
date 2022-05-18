import 'package:flutter/material.dart';
import 'package:virtual_visiting_card_pb4/db/sqlite_helper.dart';
import 'package:virtual_visiting_card_pb4/model/contact_model.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName = '/contact_new';

  @override
  _NewContactPageState createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final _nameController = TextEditingController();
  final _designationController = TextEditingController();
  final _companyController = TextEditingController();
  final _addressController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _designationController.dispose();
    _companyController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _saveContact,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter Name*',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'Please provide a valid name';
                }
                if(value.length > 20) {
                  return 'Name should be equal or less than 20 characters';
                }
                return null;
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: _mobileController,
              decoration: InputDecoration(
                labelText: 'Mobile Number*',
                prefixIcon: Icon(Icons.phone),
              ),
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'Please provide a valid number';
                }
                if(value.length < 11 || value.length > 14) {
                  return 'Invalid Number';
                }
                return null;
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _designationController,
              decoration: InputDecoration(
                labelText: 'Enter Designation',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Street Address',
                prefixIcon: Icon(Icons.apartment),
              ),
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _companyController,
              decoration: InputDecoration(
                labelText: 'Company Name',
                prefixIcon: Icon(Icons.movie),
              ),
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.url,
              controller: _websiteController,
              decoration: InputDecoration(
                labelText: 'Website',
                prefixIcon: Icon(Icons.network_cell),
              ),
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  void _saveContact() {
    if(_formKey.currentState!.validate()) {
      final contact = ContactModel(
          name: _nameController.text,
          mobileNumber: _mobileController.text,
        designation: _designationController.text,
        emailAddress: _emailController.text,
        streetAddress: _addressController.text,
        companyName: _companyController.text,
        website: _websiteController.text,
      );
      print(contact);
      DBHelper.insertContact(contact)
          .then((rowId) {
            contact.id = rowId;
            Navigator.pop(context, contact);
          })
          .onError((error, stackTrace) => throw 'could not save');
    }
  }
}
