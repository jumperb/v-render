import 'package:flutter/material.dart';

class PageWidget extends StatefulWidget {
  final State state;
  PageWidget(this.state);
  @override
  State createState() => this.state;
}

class VPage extends State {
  var title = "标题";

  PreferredSizeWidget buildAppbar(BuildContext context) {
    return AppBar(
        title: Text(title),
      );
  }

  Widget buildView(BuildContext context) {
    return Center(
      child: Text('page'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context),
      body: buildView(context),
    );
  }

  
  void routeTo(State page, {RouteTransition trans = RouteTransition.push}) {
    if (trans == RouteTransition.push) {
      Navigator.of(this.context).push(MaterialPageRoute(builder: (_) {
        return PageWidget(page);
      }));
      return;
    }
    Navigator.of(this.context).push(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> animation2){
          return PageWidget(page);
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2, Widget child) {
          switch (trans) {
            case RouteTransition.fade: {
              return FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animation1,
                  curve: Curves.fastOutSlowIn
                )),
                child: child
              );
            }  
            case RouteTransition.push:
              return null;
            case RouteTransition.rais:
              return SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: const Offset(0.0, 0.0),
                ).animate(CurvedAnimation(
                  parent: animation1,
                  curve: Curves.fastOutSlowIn
                )),                
                child: child
              );
            default:
            return null;
          }          
        }
      )
    );
  }
    
}

enum RouteTransition {
  push,
  fade,
  rais,
}