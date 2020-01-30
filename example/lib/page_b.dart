import 'package:flutter/material.dart';
import 'page.dart';
import 'package:vrender/vrender.dart';

class PageB extends Page {
  VO<int> numberA = VO(1);
  VO<int> numberB = VO(1);
  final view = MyComp();
  final view2 = MyComp();
  PageB() {    
    title = "视图组件";
    numberA.toStr().next(view.title);
    numberA.toStr().next(view2.title);
    numberB.toStr().next(view.subTitle);
    numberB.toStr().next(view2.subTitle);
    final str3 = VO.compute((){
      return "sum = ${numberA.v + numberB.v}";
    });
    str3.next(view.subTitle2);
    str3.next(view2.subTitle2);
  }
  @override
  Widget buildView(BuildContext context) {
    return Center(child: 
      Column(children: <Widget>[
        view,
        view2,
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          MaterialButton(
              color: Color(0xffff0000),            
              child:Text("a++"),
              onPressed: (){
                numberA.set(numberA.v + 1);
              }
          ),
          MaterialButton(
              color: Color(0xffff0000),
              child: Text("b++"),
              onPressed: (){
                numberB.set(numberB.v + 1);
              }
          )
        ])
      ],      
    ));
  }
}

class MyComp extends StatelessWidget {
  final VO<String> title = VO("title");
  final VO<String> subTitle = VO("subtitle");
  final VO<String> subTitle2 = VO("subtitle2");
  @override
  Widget build(BuildContext context) { 
      return Column(children:[ 
        VBind((){
          return Text(title.v);
        }),
        VBind((){
          return Text(subTitle.v);
        }),
        VBind((){
          return Text(subTitle2.v);
        })
        ],        
      );    
  }
}