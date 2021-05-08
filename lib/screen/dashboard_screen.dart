import 'dart:convert';

import 'package:aara_technologies/models/category_model.dart';
import 'package:aara_technologies/screen/main_drawer.dart';
import 'package:aara_technologies/services/call_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}


class _DashboardScreenState extends State<DashboardScreen> {

  CallApi callApi = CallApi();
  List<CategoryModel> categoryList = [];

  void init() async{

    http.Response response = await callApi.getCategory();
    Map data = jsonDecode(response.body);
    print(response.body);
    print(response.statusCode);
    if(data['response_code'] == 200){
      print('in response');

        Map responseData  = data['response_data'];



        List<dynamic> listData = responseData['data'];

        for(Map i in listData){
            categoryList.add(CategoryModel(imageUrl: 'https://traditionallymodernfood.com/wp-content/uploads/2014/04/paneer-tikka-baked-and-panini-press-9-scaled.jpeg'
                              ,id: i['cat_id'],name: i['title']));
        }
        setState(() {
          categoryList.length;
          print('fdfdgffv ${categoryList.length}');
        });

    }

    print('data recived');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(''),
        iconTheme: IconThemeData(color: Colors.grey[400]),
        elevation: 0,
        actions: [
          Container(
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.search
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),

      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
                child: Text('Buddha Bowls',style:GoogleFonts.roboto(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: CategoryTile(imageUrl: categoryList[index].imageUrl,name: categoryList[index].name,id: categoryList[index].id),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl,name,id;


  CategoryTile({this.imageUrl, this.name, this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/recipe_screen',arguments: {
          'name': name,
          'imageUrl': imageUrl,
          'id': id,
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.white)),
        child: Stack(
          children: [
            Container(width: MediaQuery.of(context).size.width/1.2,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                        borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      height: 200,

            ),
            Positioned(
              right: -50,
              child: Container(
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width /2.2,
                    height: MediaQuery.of(context).size.width / 2.2,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(name,style: GoogleFonts.roboto(fontSize: 22,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Text(id +' Food is necessary for every one',style: GoogleFonts.roboto(fontSize: 12,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}


