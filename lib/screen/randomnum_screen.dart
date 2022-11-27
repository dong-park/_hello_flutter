import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeRandomScreen extends StatefulWidget {
  const HomeRandomScreen({Key? key}) : super(key: key);

  @override
  State<HomeRandomScreen> createState() => _HomeRandomScreenState();
}

class _HomeRandomScreenState extends State<HomeRandomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Random Number',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(onPressed: () => {}, icon: Icon(Icons.settings))
              ],
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("123"),
                Text("456"),
                Text("789"),
              ],
            )),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => {}, child: Text("Generate")))
          ],
        ),
      ),
    );
  }
}
