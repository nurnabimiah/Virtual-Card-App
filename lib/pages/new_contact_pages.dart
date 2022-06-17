import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_card_application/pages/contact_list_page.dart';

import '../models/contact_model.dart';
import '../providers/contact_provider.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName = '/new_contact';

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {

  final _formkey = GlobalKey<
      FormState>(); // ei key ta form er ekta state k daron korbe
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _companyController = TextEditingController();
  final _designationController = TextEditingController();
  final _websiteController = TextEditingController();
  String image = "";

  late ContactProvider _provider;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if(_isInit){
      _provider =  Provider
          .of<ContactProvider>(context,listen: false);
      final contact = ModalRoute.of(context)!. settings.arguments as ContactModel;
       image = contact.image;
      _nameController.text = contact.name;
      _mobileController.text = contact.mobile;
      _emailController.text = contact.email;
      _addressController.text = contact.address;
      _companyController.text = contact.company;
      _designationController.text = contact.designation;
      _websiteController.text = contact.website;



      _isInit = false;

    }

    super.didChangeDependencies();
  }


  /* ai dispose method ta tokhoni use kri jokhn kono state object er modde
   controller name a kono kiso use kri
   * */
  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _companyController.dispose();
    _designationController.dispose();
    _websiteController.dispose();
    super
        .dispose(); /*ai page thekhe jokhon amra onno page a jabo tokhon call hobe dispose*/

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact Page'),
        actions: [
          IconButton(
              onPressed: _saveContact,


              icon: Icon(Icons.save))

        ],
      ),
      body: Form(
        key: _formkey, // ei key dore ami form er valu golo k access korte parbo
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [

            /* contact*/
            TextFormField(/*joto gola filed thakbe totho gola controller banaite hobe*/
              controller: _nameController,
              // controller diye value golo newa hoy
              decoration: InputDecoration(
                labelText: 'Contact Name*',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),


              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This filed must not be empty';
                }

                if (value.length > 20) {
                  return 'Name should be less than 20 character';
                }
                return null;
              },


            ),

            SizedBox(height: 10,),

            /* mobile number*/


            TextFormField(/*joto gola filed thakbe totho gola controller banaite hobe*/
              controller: _mobileController,
              // controller diye value golo newa hoy
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number*',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),


              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This filed must not be empty';
                }

                return null;
              },


            ),

            SizedBox(height: 10,),

            /*email address*/


            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),


              ),

              validator: (value) {
                return null;
              },


            ),

            SizedBox(height: 10,),


            /*address*/


            TextFormField(
              controller: _addressController,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                labelText: 'Street Address',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),


              ),

              validator: (value) {
                return null;
              },


            ),

            SizedBox(height: 10,),


            /*company Name*/
            TextFormField(/*joto gola filed thakbe totho gola controller banaite hobe*/
              controller: _companyController,
              // controller diye value golo newa hoy
              decoration: InputDecoration(
                labelText: 'Company Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),


              ),

              validator: (value) {
                return null;
              },


            ),

            SizedBox(height: 10,),


            /* Designation*/
            TextFormField(/*joto gola filed thakbe totho gola controller banaite hobe*/
              controller: _designationController,
              // controller diye value golo newa hoy
              decoration: InputDecoration(
                labelText: 'Designation',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),


              ),

              validator: (value) {
                return null;
              },


            ),

            SizedBox(height: 10,),


            /*website*/
            TextFormField(
              controller: _websiteController,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: 'Website name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),

              ),

              validator: (value) {
                return null;
              },

            ),

          ],


        ),
      ),
    );


    /* protiti filed thekhe information golo k nite hobe  er jonno amder k form er ekta
   unique key dite hobe, r ei key ta  k dite hoy kono ekta widget k identify korar jonno and globally access korar jonno*/


  }

  void _saveContact() {
    if (_formkey.currentState!.validate()) {

      final contact = ContactModel(
        name: _nameController.text,
        mobile:_mobileController.text,
        email: _emailController.text,
        address: _addressController.text,
        company: _companyController.text,
        designation: _designationController.text,
        website: _websiteController.text,
        image: image,
      );

      _provider.insertContact(contact).then((rowId) {
        contact.id = rowId;
        _provider.updateList(contact);
        Navigator.popUntil(context, ModalRoute.withName(ContactListPage.routeName));

      }).catchError((error){
        throw error;
      });



    }
  }
}

/* data insert korar korar jonno amader lekhte hoy, age db helper a kaj korte hobe

Provider.of<ContactProvider>(context, listen:false)
.insertContact(contact)*/

/* button press korar sathe sathe ekta condition cheack korbo, form er j currrent state ase
er validate name a ekta mathod ase, ai validate method ta text filed er all validate function ta ke
eksathe call korbe, sob golo jodi null return kre,tarmane proti ta te value dewa ase tahole ei function
ta true return korbe
 */
