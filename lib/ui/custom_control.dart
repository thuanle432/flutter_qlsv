

import 'package:connection/models/place.dart';
import 'package:connection/models/profile.dart';
import 'package:flutter/material.dart';

import '../models/lop.dart';



class Custom_button extends StatelessWidget {
  const Custom_button({
    super.key, required this.textButton,
  });
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.yellow,
      ),
      child:  Center(
        child: Text(textButton,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        )
      ),
    );
  }
}

class CustomSpinner extends StatelessWidget {
  const CustomSpinner({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.deepPurple.withOpacity(0.5),
      child: const Center(
        child: Image(
          width: 50,
          image: AssetImage("assets/images/spinner.gif"),
        ),
      ),
    );
  }
}

class Customavatar1 extends StatelessWidget {
  const Customavatar1({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.height*0.25),
      child: Container(
        width: 100,
        height: 100,
        child: Image.network(
          Profile().user.avatar,
          fit: BoxFit.cover,
        )
        ),
    );
  }
}


class CustomTextInputFormField extends StatefulWidget {
  const CustomTextInputFormField({
    super.key,
    required this.width, 
    required this.title, 
    required this.value, 
    required this.callback,
    this.type = TextInputType.text
  });


  final double width;
  final String title;
  final String value;
  final TextInputType type;
  final Function (String output) callback;
  

  @override
  State<CustomTextInputFormField> createState() => _CustomTextInputFormFieldState();
}

class _CustomTextInputFormFieldState extends State<CustomTextInputFormField> {

  int status = 0;
  String output = "";

  @override
  void initState() {
    // TODO: implement initState
    output = widget.value;
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title),
          status == 0? 
          GestureDetector(
            onTap: () {
              setState(() {
                status = 1;
              });
            },
            child: Text(
              widget.value == ""?"Không có":widget.value
              )):
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200]
                  ),
                  width: widget.width - 60,
                   child: TextFormField(
                    keyboardType: widget.type,
                    decoration: InputDecoration(border: InputBorder.none),
                    initialValue: output,
                    onChanged: (value) {
                      setState(() {
                        output = value;
                        widget.callback(output);
                      });
                      
                    },
                  ),
                 ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      status = 0;
                      widget.callback(output);
                    });
                  },
                  child: const Icon(
                    Icons.save,
                    size: 18,
                  ),
                )
               ],
             ),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}





class CustomTextInputDropDown extends StatefulWidget {
  const CustomTextInputDropDown({
    super.key,
    required this.width, required this.title, required this.valueid, required this.callback, required this.list, required this.valuename,
  });


  final double width;
  final String title;
  final int valueid;
  final String valuename;
  final List<Lop> list;
  final Function (int outputid,String outputname) callback;

  @override
  State<CustomTextInputDropDown> createState() => 
  _CustomTextInputDropDownState();
}

class _CustomTextInputDropDownState extends State<CustomTextInputDropDown> {

  int status = 0;
  int outputid = 0;
  String outputname = "";

  @override
  void initState() {
    // TODO: implement initState
    outputid = widget.valueid;
    outputname = widget.valuename;
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        status == 0? 
        GestureDetector(
          onTap: () {
            setState(() {
              status = 1;
            });
          },
          child: Text(
            outputname == ""?"Không có":outputname
            )):
           Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200]
            ),
            width: widget.width - 25,
             child: DropdownButton(value: outputid,
             items: widget.list.map((e) => DropdownMenuItem(
              value: e.id,
              child: Container(
                width: widget.width * 0.8,
                
                child: Text(e.ten, overflow: TextOverflow.ellipsis
                ,)))).toList(),
              onChanged: (value) {
                setState(() {
                  outputid = value!;
                  for(var dropitem in widget.list){
                    if(dropitem.id == outputid){
                      outputname = dropitem.ten;
                      widget.callback(outputid, outputname);
                      break;
                    }
                  }
                  status = 0;
                });
              },
              
              
              ),
           ),
        const Divider(
          thickness: 1,
        )
      ],
    );
  }
}


class CustomPlaceDropDown extends StatefulWidget {
  const CustomPlaceDropDown({
    super.key,
    required this.width, 
    required this.title, 
    required this.valueid, 
    required this.callback, 
    required this.list, 
    required this.valueName,
  });


  final double width;
  final String title;
  final int valueid;
  final String valueName;
  final List<Place> list;
  final Function (int outputid,String outputname) callback;

  @override
  State<CustomPlaceDropDown> createState() => 
  _CustomPlaceDropDownState();
}

class _CustomPlaceDropDownState extends State<CustomPlaceDropDown> {

  int status = 0;
  int outputid = 0;
  String outputname = "";

  @override
  void initState() {
    // TODO: implement initState
    outputid = widget.valueid;
    outputname = widget.valueName;
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.red,
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title),
          status == 0? 
          GestureDetector(
            onTap: () {
              setState(() {
                status = 1;
              });
            },
            child: Text(
              widget.valueName == ""?"Không có":widget.valueName
              )):
             Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200]
              ),
              width: widget.width,
               child: DropdownButton(value: widget.valueid,
               items: widget.list.map((e) => DropdownMenuItem(
                value: e.id,
                child: Container(
                  width: widget.width - 45 ,
                  child: Text(
                    e.name, 
                    overflow: TextOverflow.ellipsis
                  ,)))).toList(),
                onChanged: (value) {
                  setState(() {
                    outputid = value!;
                    for(var dropitem in widget.list){
                      if(dropitem.id == outputid){
                        outputname = dropitem.name;
                        widget.callback(outputid, outputname);
                        break;
                      }
                    }
                    status = 0;
                  });
                },
                
                
                ),
             ),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}