import 'dart:math';

const String tblContact = 'tbl_contact';
const String tblContactColId = 'id';
const String tblContactColName = 'name';
const String tblContactColCompanyName = 'company';
const String tblContactColDesignation = 'designation';
const String tblContactColMobile = 'mobile';
const String tblContactColEmail= 'email';
const String tblContactColAddress= 'address';
const String tblContactColWebsite= 'website';
const String tblContactColFavorite= 'favorite';
class ContactModel {
  int? id;
  String name;
  String? designation;
  String? emailAddress;
  String mobileNumber;
  String? streetAddress;
  String? companyName;
  String? website;
  bool favorite;

  ContactModel(
      {this.id,
      required this.name,
      this.designation,
      this.emailAddress,
      required this.mobileNumber,
      this.streetAddress,
      this.companyName,
        this.favorite = false,
      this.website});

  factory ContactModel.fromMap(Map<String, dynamic> map) => ContactModel(
    name: map[tblContactColName],
    mobileNumber: map[tblContactColMobile],
    id: map[tblContactColId],
    designation: map[tblContactColDesignation],
    emailAddress: map[tblContactColEmail],
    companyName: map[tblContactColCompanyName],
    website: map[tblContactColWebsite],
    streetAddress: map[tblContactColAddress],
    favorite: map[tblContactColFavorite] == 1 ? true : false,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      tblContactColName : name,
      tblContactColCompanyName : companyName,
      tblContactColDesignation : designation,
      tblContactColAddress : streetAddress,
      tblContactColMobile : mobileNumber,
      tblContactColEmail : emailAddress,
      tblContactColWebsite : website,
      tblContactColFavorite : favorite ? 1 : 0,
    };

    if(id != null) {
      map[tblContactColId] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, designation: $designation, emailAddress: $emailAddress, mobileNumber: $mobileNumber, streetAddress: $streetAddress, companyName: $companyName, website: $website, favorite: $favorite}';
  }
}