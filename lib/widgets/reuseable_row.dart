import 'package:flutter/material.dart';

class ReuseableRow extends StatelessWidget {
  String title,value;
   ReuseableRow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: TextStyle(fontSize: 17),),
              Text(value,style: TextStyle(fontSize: 17),),
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}
