import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pipok_app/src/models/movie_list_model.dart';
import 'package:pipok_app/src/personal_lists/widgets/personal_lists/personal_lists_controller.dart';
import 'package:pipok_app/src/shared/auth/auth_controller.dart';
import 'package:provider/provider.dart';



class PersonalListsWidget extends StatefulWidget {
  final PersonalListsController controller;

  const PersonalListsWidget({Key key, @required this.controller}) : super(key: key);
  @override
  _PersonalListsWidgetState createState() => _PersonalListsWidgetState();
}

class _PersonalListsWidgetState extends State<PersonalListsWidget> {
  @override
  Widget build(BuildContext context) {
   

    return Observer(
      builder: (context) {
        if (widget.controller.personalListsStream.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: .8),
            itemCount: widget.controller.personalListsStream.data.length,
            itemBuilder: (context, index) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'http://image.tmdb.org/t/p/w185/'
                      '${widget.controller.personalListsStream.data[index].imageUrl}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                     
                      Spacer(),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(left: 20, bottom: 15),
                        child: Text(
                          '${widget.controller.personalListsStream.data[index].name}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.only(right: 20, bottom: 15),
                        child: Text(
                          '${widget.controller.personalListsStream.data[index].favorites.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );

       
      },
    );
  }
}
