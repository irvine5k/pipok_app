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

        return Expanded(
          child: ListView.builder(
            itemCount: widget.controller.personalListsStream.data.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(
                  widget.controller.personalListsStream.data[index].name,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onPressed: () {
                    
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
