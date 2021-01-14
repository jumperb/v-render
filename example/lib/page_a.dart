import 'package:flutter/material.dart';
import 'page.dart';
import 'package:vrender/vrender.dart';

class PageA extends VPage {
  VO<int> numberA = VO(1);
  VO<int> numberB = VO(1);
  VO<int> numberC = VO(1);
  VO<int> numberD = VO(1);
  VO<List> list = VO(["vrow示例",1,2,3,4]);
  PageA() {
    title = "数据绑定";
    list.v.add(numberA);
  }

  @override
  Widget buildView(BuildContext context) {
    return Center(child: 
      Column(children: [
          VBind((){
            return Text("a=${numberA.v}");
          }),
          VBind((){
            return Text("b=${numberB.v}");
          }),
          VBind((){
            return Text("sum=${numberA.v + numberB.v}");
          }),
          VBind((){
            return Text("mlt=${numberA.v * numberB.v}");
          }),
          VBind((){        
            int max = numberA.v;
            if (max < numberB.v) {
              max = numberB.v;
            }
            return Text("max=$max");
          }),
          VRow(list, (int index, var o){
            if (o is VO)
            {
              VO vo = o;
              return VBind((){
                return Text("${vo.v}");
              });
            }
            else {
              return Text("$o");
            }
          }),      
          Row(children: [
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
            ),
            MaterialButton(
              color: Color(0xffff0000),
              child: Text("改变数组"),
              onPressed: (){
                list.change((List o){
                  o.add("增加的");
                });
              }
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center)          
        ]
      )
    );
  }
}