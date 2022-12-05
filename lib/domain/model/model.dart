class SliderObject{
  String title;
  String subTitle;
  String image;

  SliderObject(this.title,this.subTitle,this.image);
}

//im here after generating app_api.dart files
//we are creating models for each and every class which is in Response.
//every value should be non nullable(so we can pass in presentation layer)

class Customer{
  String name;
  String id;
  int numOfNotifications;

  Customer(this.id,this.name,this.numOfNotifications);
}

class Contacts{
  String phone;
  String link;
  String email;

  Contacts(this.phone,this.link,this.email);
}

class Authentication{
  Customer customer;
  Contacts contacts;

  Authentication(this.customer,this.contacts);
}

class DeviceInfo{
  String name;
  String identifier;
  String version;

  DeviceInfo(this.name,this.identifier,this.version);
}