import 'package:final_project/AddItemNotifier.dart';
import 'package:flutter/material.dart';

import 'details.dart';
import 'item.dart';

class WishList extends StatefulWidget{
  final List <Item> items;
  const WishList({super.key, required this.items});

  @override
  State<StatefulWidget> createState()=> _WishListChangeState();
}

class _WishListChangeState extends State<WishList>{
  final AddValueNotifier _addValueNotifier= AddValueNotifier();
  bool _isExpanded=false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: const Text("Wishlist Manager")),
        body:
            Container(
                color:  Colors.black12,
                child:
                ListView(
                  children: [
                    Container(
                        color: Colors.lime,
                      child:
                      ExpansionTile(
                        key: GlobalKey(),
                        expandedAlignment: Alignment.center,
                        title: const Text('Add Item',style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                        onExpansionChanged: (value) {
                          _isExpanded = value;
                        },
                        initiallyExpanded: _isExpanded,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 160),
                            child: Column(
                              children: [
                                ValueListenableBuilder<Item>(
                                    valueListenable: _addValueNotifier,
                                    builder:(context, value, child) {
                                      return TextField(
                                        onChanged: (text){
                                          _addValueNotifier.update(itemName: text);
                                        },
                                        obscureText: false,
                                        decoration:  InputDecoration(
                                            prefixIcon: const Icon(Icons.text_fields),
                                            border: const UnderlineInputBorder(),
                                            labelText: "Item Name: ",
                                          hoverColor: Colors.deepPurpleAccent.withOpacity(1),
                                      ));
                                    }
                                ),
                                ValueListenableBuilder<Item>(
                                    valueListenable: _addValueNotifier,
                                    builder:(context, value, child){
                                      return (TextField(
                                        onChanged: (text){
                                          _addValueNotifier.update(itemDescription: text.toString());
                                        },
                                        obscureText: false,
                                        decoration: const InputDecoration(
                                            hoverColor: Colors.lime,
                                            prefixIcon: Icon(Icons.text_fields),
                                            border: UnderlineInputBorder(),
                                            labelText: "Item Description: "
                                        ),
                                      ));
                                    }
                                ),
                                ValueListenableBuilder<Item>(
                                    valueListenable: _addValueNotifier,
                                    builder:(context, value, child){
                                      return(
                                          TextField(
                                            onChanged: (text){
                                              _addValueNotifier.update(itemUrl: text.toString());
                                            },
                                            obscureText: false,
                                            decoration: const InputDecoration(
                                                hoverColor: Colors.lime,
                                                prefixIcon: Icon(Icons.text_fields),
                                                border: UnderlineInputBorder(),
                                                labelText: "Item URL"
                                            ),
                                          )
                                      );
                                    }
                                ),
                                ValueListenableBuilder<Item>(
                                    valueListenable: _addValueNotifier,
                                    builder:(context, value, child){
                                      return(
                                          TextField(
                                            onChanged: (text){
                                              _addValueNotifier.update(itemImageUrl: text.toString());
                                            },
                                            obscureText: false,
                                            decoration: const InputDecoration(
                                                hoverColor: Colors.lime,
                                                prefixIcon: Icon(Icons.image),
                                                border: UnderlineInputBorder(),
                                                labelText: "Image URL"
                                            ),
                                          )
                                      );
                                    }
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
                                  child:
                                  ValueListenableBuilder<Item>(
                                      valueListenable: _addValueNotifier,
                                      builder:(context, value, child) {
                                        return ElevatedButton(
                                          onPressed: () {
                                            if(value.itemName.trim()=="" || value.itemDescription.trim()=="" || value.itemUrl.trim()=="" || value.itemImageUrl=="") {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text("Please ensure to fill out all the fields!"),
                                                  duration: Duration(seconds: 3),
                                                  backgroundColor: Colors.red,
                                                  behavior: SnackBarBehavior.floating,
                                                ),
                                              );
                                            }
                                            else
                                              {
                                                setState(() {
                                                  _isExpanded=!_isExpanded;
                                                  widget.items.insert(0,Item(
                                                      itemName: value.itemName,
                                                      itemDescription: value.itemDescription,
                                                      itemImageUrl: value.itemImageUrl,
                                                      itemUrl: value.itemUrl
                                                  ));
                                                });
                                                _addValueNotifier.reset(); // Clear the input states
                                              }

                                          },
                                          child: const Text("Add item"),
                                        );
                                      }
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    )
                   ,

                    Container(
                        height: MediaQuery.of(context).size.height * 0.9,

                        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                        child:
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 140),
                          itemCount: widget.items.length ,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                                height: 300,
                                margin: const EdgeInsets.all(20),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),color: Colors.black87,),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child:
                                        Container(
                                          margin: const EdgeInsets.all(20),
                                          child: Image.network(widget.items[index].itemImageUrl, fit: BoxFit.cover),
                                        )),
                                    Expanded(
                                      flex:4,
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 30),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:[
                                            Row(
                                              children: [
                                                const Text(
                                                  "Item name: ",
                                                  style: TextStyle(
                                                    color: Colors.lime,
                                                    fontWeight: FontWeight.bold,
                                                    height: 2,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    widget.items[index].itemName,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      height: 2,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Item description: ",
                                                  style: TextStyle(
                                                    color: Colors.lime,
                                                    fontWeight: FontWeight.bold,
                                                    height: 2,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    widget.items[index].itemDescription,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      height: 2,

                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(

                                              margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
                                              child:
                                              Row(
                                                  children:[
                                                    Container(
                                                        margin: const EdgeInsets.only(right: 30),
                                                        child: ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor: MaterialStateProperty.all<Color>(
                                                              Colors.deepPurpleAccent,
                                                            ),
                                                          ),
                                                          onPressed: (){
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(builder: (context)=>  Details(item:widget.items[index])),
                                                            );
                                                          },
                                                          child: const Text(
                                                            "View details",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ))
                                                    ,
                                                    ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor: MaterialStateProperty.all<Color>(
                                                          Colors.deepPurpleAccent,
                                                        ),
                                                      ),
                                                      onPressed: (){
                                                        setState((){
                                                          widget.items.removeAt(index);
                                                        });
                                                      },
                                                      child: const Text(
                                                        "Delete Item",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    )
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            );
                          },
                        )
                    )
                  ],
                )
            ) ,

    );
  }
}
