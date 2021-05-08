import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.map,size: 40,color: Colors.blueAccent,),
            title: Text(
              'GoogleMap',
              style: GoogleFonts.roboto(fontSize: 22),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/google_map_screen');
            },
          ),
        ],
      ),
    );
  }
}
