
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'item.dart';

class Details extends StatefulWidget{
 Item item;
 Details({super.key,required this.item});
 @override
 State<StatefulWidget> createState()=> _DetailsChangeState();
}

class _DetailsChangeState extends State<Details>{
  _launchUrl () async{
      String url = widget.item.itemUrl;
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details")
      ),
      body:
    Container(

                  height: 600,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),color: Colors.black87,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 4,
                          child:
                          Container(
                            margin: const EdgeInsets.all(20),

                            child: Image.network(widget.item.itemImageUrl, fit: BoxFit.cover),
                          )),
                      Expanded(
                        flex:3,
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
                                      widget.item.itemName,
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
                                      widget.item.itemDescription,
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[
                                      Container(
                                          margin: const EdgeInsets.only(right: 30),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(
                                                Colors.deepPurpleAccent,
                                              ),
                                            ),
                                            onPressed: _launchUrl,
                                            child: const Text(
                                              "Visit website",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                      )
                                      ,
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  )
    )

    );
  }
}