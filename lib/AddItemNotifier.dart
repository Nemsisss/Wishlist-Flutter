import 'package:flutter/cupertino.dart';

import 'item.dart';

class AddValueNotifier extends ValueNotifier<Item>{
  AddValueNotifier(): super(Item(itemName:"", itemDescription:"", itemImageUrl:"", itemUrl:""));
  reset(){
    value.itemName="";
    value.itemDescription="";
    value.itemImageUrl="";
    value.itemUrl="";
  }
  void update({String? itemName, String? itemDescription, String? itemImageUrl, String? itemUrl}){
    value= Item(itemName: itemName ?? value.itemName, itemDescription: itemDescription ?? value.itemDescription, itemImageUrl: itemImageUrl ?? value.itemImageUrl, itemUrl: itemUrl ?? value.itemUrl);
  }
}