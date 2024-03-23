import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasheh/screens/upload_screen.dart';
import 'package:tasheh/reusable_widgets/reusable_widget.dart';


class profile_screen extends StatelessWidget {
  const profile_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile',
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/images/prof_img.jpg'),
                ),
                const SizedBox(height: 20),
                itemProfile('Name', 'Abdallah syaj', CupertinoIcons.person),
                const SizedBox(height: 10),
                itemProfile('Phone', '0795126556', CupertinoIcons.phone),
                const SizedBox(height: 10),
                itemProfile('Address', 'Amman , Jordan', CupertinoIcons.location),
                const SizedBox(height: 10),
                itemProfile('Email', 'abdallah.ali.syaj@gmail.com', CupertinoIcons.mail),
                const SizedBox(height: 20,),
                SizedBox(
                  width: double.infinity,
                  child: firebaseUIButton(context, 'Edit profile', () {} ,
                      Color.fromRGBO(72, 6, 7, 1)
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: firebaseUIButton(context, 'Add Event', () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => up_screen()));
                  } ,
                      Color.fromRGBO(72, 6, 7, 1)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Color.fromRGBO(72, 6, 7, 0.8),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
}