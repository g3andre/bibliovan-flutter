import 'package:bibliovan/utils/response_managment.dart';
import 'package:bibliovan/widgets/circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ListViewWidget extends StatelessWidget {
  ResponseManagment responseManagment;
  var storeObserver;
  Function onItemSelected;

  ListViewWidget({this.responseManagment});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (this.storeObserver == null) {
          return CircularProgress();
        }

        return _listView(storeObserver);
      },
    );
  }

  ListView _listView(List list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => onItemSelected(list[index]),
            child: Card(
              child: Center(
                child: Row(
                  children: <Widget>[
                    list[index].urlFoto != null
                        ? Image.network(
                            list[index].urlFoto,
                            scale: 5,
                          )
                        : Image.asset("assets/images/user.png"),
                    //Text list[index].nome)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
