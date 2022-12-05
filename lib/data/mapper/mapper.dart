//to convert the response into null nullable object (model)
//passing data to domain

import 'package:advanced_flutter/app/extensions.dart';
import 'package:advanced_flutter/data/responses/responses.dart';
import 'package:advanced_flutter/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;
//converting customerResponse to NonNullable Customer
extension CustomerResponseMapper on CustomerResponse?{

  Customer toDomain(){
    return Customer(this?.id?.orEmpty() ?? EMPTY, this?.name?.orEmpty() ?? EMPTY, this?.numOfNotifications?.orZero()??ZERO);
  }
}

//converting contactResponse to NonNullable Contact
extension ContactResponseMapper on ContactsResponse?{

  Contacts toDomain(){
    return Contacts(this?.phone?.orEmpty() ?? EMPTY, this?.link?.orEmpty() ?? EMPTY, this?.email?.orEmpty()??EMPTY);
  }
}

//authentication response mapper
extension AuthenticationResponseMapper on AuthenticationResponse{

  Authentication toDomain(){
    return Authentication(customer.toDomain(),contacts.toDomain());
  }
}