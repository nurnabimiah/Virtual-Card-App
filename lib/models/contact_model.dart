

final String tableContact = 'tbl_contact';
final String tblContactColId = 'id';
final String tblContaqctColName = 'name';
final String tblContaqctColMobile = 'mobile';
final String tblContaqctColEmail = 'email';
final String tblContaqctColAddress = 'address';
final String tblContaqctColCompany = 'company';
final String tblContaqctColDesignation = 'designation';
final String tblContaqctColWebsite = 'website';
//const String tblContaqctColFavourite = 'favorite';
final String tblContaqctColImage = 'image';



 class ContactModel{
   int id;
String name;
String mobile;
String email;
String address;
String company;
String designation;
String website;
String image;
//bool favortite;


ContactModel(
{
required this.name,
required this.mobile,
this.id = 0,
this.email = '',
this.address = '',
this.company = '',
this.designation = '',
this.website = '',
this.image = 'https://thumbs.dreamstime.com/b/cute-boy-young-charming-man-looking-ahead-twinkling-34856138.jpg',
//this.favortite = false
});

/* to map method ta tokhn call korbo jokhn amra insert korte jabo or update korte jabo */
   Map<String, dynamic> toMap() {
     var map = <String, dynamic>{
       tblContaqctColName: name,
       tblContaqctColMobile: mobile,
       tblContaqctColEmail: email,
       tblContaqctColAddress: address,
       tblContaqctColCompany: company,
       tblContaqctColDesignation: designation,
       tblContaqctColImage: image,
       tblContaqctColWebsite: website,
       /*akhon id ta aikhane include korbo na karon aita auto increment hobe
      ,update korar time a id ta include korte hobe*/


     };
     if(id>0){
       map[tblContactColId] = id;  // ai code ta tokhoni exectute hobe jokhn amra update korte jabo;
     }
     return map;
   }

   /* ai map ta k contact model a convet korte hobe,jeno qury kore amra data base thekhe ante pari*/
   factory ContactModel.fromMap(Map<String,dynamic>map) => ContactModel(
     id: map[tblContactColId],
     name: map[tblContaqctColName],
     mobile: map[tblContaqctColMobile],
     email: map[tblContaqctColEmail],
     address: map[tblContaqctColAddress],
     company: map[tblContaqctColCompany],
     designation: map[tblContaqctColDesignation],
     website: map[tblContaqctColWebsite],
     image: map[tblContaqctColImage],

     /* ai method ta k call korbo amra proti ta qury korar time a ,query korate amader jotho gola map
     proti ta row er jonno,ekta kore map pabo,ekta map mane ekta contact model,sei map ta k amra
     ekta contact model a er object convert korbo,jeno amra data golo k show korbo tokhon jeno
     contact model er object pore dot diye property golo access korte pari, jeno map diye access korte na hoy */
   );



   @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, mobile: $mobile, email: $email, address: $address, company: $company, designation: $designation, website: $website, image: $image}';
  }
}