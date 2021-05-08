import 'dart:convert';

import 'package:aara_technologies/models/category_model.dart';
import 'package:aara_technologies/services/call_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class RecipeScreen extends StatefulWidget {
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {

  Map data = {};
  CallApi callApi = CallApi();
  List<CategoryModel> RecipeList = [];

  void inti() async{
   http.Response response = await  callApi.getRecipes(data['id']);

   Map data1 = jsonDecode(response.body);
   if(data1['status'] == true){
     Map responseData  = data1['response_data'];
     List<dynamic> listData = responseData['data'];

     for(Map i in listData){
       RecipeList.add(CategoryModel(imageUrl: 'https://traditionallymodernfood.com/wp-content/uploads/2014/04/paneer-tikka-baked-and-panini-press-9-scaled.jpeg'
           ,id: i['subcat_id'],name: i['title']));
     }
     setState(() {
       RecipeList.length;
       print('recipe list ${RecipeList.length}');
     });

   }


   print(response.statusCode);
   print(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      // Do something
      inti();
    });


  }

  @override
  Widget build(BuildContext context) {

    data = ModalRoute
        .of(context)
        .settings
        .arguments;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(data['name'],style: GoogleFonts.roboto(color: Colors.black),),
          centerTitle: true,
          elevation: 0,
        ),
      body: ListView.builder(
        itemCount: RecipeList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: RecipesCard(name: RecipeList[index].name,imageUrl: 'https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/216054.jpg',
                                ),
          );
        },
      ),
    );
  }
}



class RecipesCard extends StatelessWidget {

  final String name,imageUrl;
  RecipesCard({this.name, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 2.5,
                  ),
                ),
              ),
              SizedBox(height: 4,),
              Text(name== null? 'Pizza': name,style: GoogleFonts.roboto(fontSize: 18),),
              SizedBox(height: 4,),
            ],
          ),
          Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.bookmark_border,size: 25,color: Colors.grey,)
          ),
        ],
      ),
    );
  }
}