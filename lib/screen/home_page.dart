import 'dart:convert';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String,dynamic> ? exerciseData;
   fetchExerciseData()async{
     var url ="https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR3Vw_T1PfBmWKquaVYFJIhiJ8ZEPehdGeo4zNcSgXh1gEuqMs6s_ouJJN8";
     var data = await http.get(Uri.parse(url));
     print(data.body);
     var getdata =  jsonDecode(data.body);

     setState(() {
       exerciseData = Map<String, dynamic>.from(getdata);
       print("Excercise data...........................................................");
       print(exerciseData);
     });
   }

   @override
  void initState() {
     fetchExerciseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitness App"),
      ),
      body: exerciseData ==null ? Center(child:CircularProgressIndicator()): ListView.builder(
        itemCount: exerciseData!['exercises'].length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index)
          =>Container(
            height: 200,
            width: double.infinity,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red,
              image: exerciseData==null? DecorationImage(image: NetworkImage("https://t4.ftcdn.net/jpg/03/08/68/19/360_F_308681935_VSuCNvhuif2A8JknPiocgGR2Ag7D1ZqN.jpg"),fit: BoxFit.cover): DecorationImage(image: NetworkImage("${exerciseData!['exercises'][index]['thumbnail']}"),fit: BoxFit.cover),
            ),
            child:Column(
              children: [
                Text("${exerciseData!['exercises'][index]['title']}"),
              ],
            )
            //child: Text("${exerciseData![index]["title"]}"),
          )),
    );
  }
}
