import 'package:flutter/material.dart';

main() => runApp(CallHistory());

class CallHistory extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    Widget nameSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'JEONGHWAN KIM',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
              Text(
                '21400181',
                style:TextStyle(color: Colors.grey[500]),
              ),
            ],
          ),
        ),
        FavoriteWidget(),
      ],
    ),
  );

  Column _buildButtonColumn(Color color, IconData icon, String label){
    // Return a button of Column widget
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Icon(icon, color:color),
        Container(
          margin: const EdgeInsets.only(top:8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Color color = Colors.black;

  Widget buttonSection = Container(
    padding:EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:[
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.message, 'MESSAGE'),
        _buildButtonColumn(color, Icons.email, 'EMAIL'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
        _buildButtonColumn(color, Icons.note, 'ETC'),
      ],
    ),
  );

  Widget textSection = Container(
    padding: const EdgeInsets.all(32.0),
    child: 
      ListTile(
        leading: Icon(Icons.message, size: 40.0, color: Colors.black),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Message', 
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Long time no see!',
                    style: TextStyle(color: Colors.grey[500]),
                    softWrap: true,
                  ),
                ]
              ),
            ),
          ],
        ),
    ),
  );

  return MaterialApp(
    title: 'Phone',
    home: Scaffold(
      body: ListView(
        children:[
          Image.asset(
            'assets/jeonghwan.jpg',
            width: 600,
            height: 240,
            fit:BoxFit.cover,
          ),
          nameSection,
          Divider(
            height: 1.0,
            color: Colors.black,
          ),
          buttonSection,
          Divider(
            height: 1.0,
            color: Colors.black,
          ),
          textSection,
        ],
        ),
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget>{
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisSize:MainAxisSize.min,
      children:[
        Container(
          padding:EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.yellow[500],
            onPressed: _toggleFavorite,
          ),
        ),
      ]
    );
  }

  void _toggleFavorite(){
    setState((){
      if(_isFavorited){
        _isFavorited = false;
        //print('_isFavorited:' + _isFavorited.toString());
      }
      else{
        _isFavorited = true;
        //print('_isFavorited:' + _isFavorited.toString());
      }
    });
  }
}