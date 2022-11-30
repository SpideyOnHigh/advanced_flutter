//extension functions to convert null data into empty data

//extension on string
extension NonNullString on String{
  String orEmpty(){
    if(this == null){
      return "";
    }
    return this;
  }
}

//extension on int
extension NonNullInteger on int{
  int orZero(){
    if(this == null){
      return 0;
    }
    return this;
  }
}