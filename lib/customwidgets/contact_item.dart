import 'package:flutter/material.dart';
import 'package:virtual_visiting_card_pb4/db/sqlite_helper.dart';
import 'package:virtual_visiting_card_pb4/model/contact_model.dart';
import 'package:virtual_visiting_card_pb4/pages/contact_details_page.dart';

class ContactItem extends StatefulWidget {
  final ContactModel contactModel;
  final VoidCallback callback;
  ContactItem(this.contactModel, this.callback);

  @override
  _ContactItemState createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: _showConfirmationDialog,
      onDismissed: (direction) {
        DBHelper.deleteContact(widget.contactModel.id!);
      },
      background: Container(
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete, color: Colors.white,),
      ),
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, ContactDetailsPage.routeName, arguments: [widget.contactModel.id, widget.contactModel.name]);
          },
          title: Text(widget.contactModel.name),
          trailing: IconButton(
            icon: Icon(widget.contactModel.favorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              final value = widget.contactModel.favorite ? 0 : 1;
              DBHelper.updateContactFavorite(widget.contactModel.id!, value)
                  .then((_) {
                setState(() {
                  widget.contactModel.favorite = !widget.contactModel.favorite;
                });
              }).catchError((error) {
                throw error;
              });
            },
          ),
        ),
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(DismissDirection direction) {
    return showDialog(context: context, builder: (context) => AlertDialog(
              title: Text('Delete ${widget.contactModel.name}?'),
              content: const Text('Are you sure to delete this contanct?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('CANCEL')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text('YES')),
              ],
            ));
  }

}
