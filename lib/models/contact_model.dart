

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


  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, mobile: $mobile, email: $email, address: $address, company: $company, designation: $designation, website: $website,image:$image}';
  }
}