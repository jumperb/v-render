part of 'page_c.dart';

Widget cPageView(PageC page) {
  return Center(child: 
      Column(children: <Widget>[
        VBind((){
          return Text("a = ${page.numberA.v}");
        }),
        VBind((){
          return Text("b = ${page.numberB.v}");
        }),
        VBind((){
          return Text("a+b = ${page.numberA.v + page.numberB.v}");
        }),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          MaterialButton(
              color: Color(0xffff0000),            
              child:Text("a++"),
              onPressed:page.addA,
          ),
          MaterialButton(
              color: Color(0xffff0000),
              child: Text("b++"),
              onPressed: page.addB
          )
        ])       
      ],      
    ));  
}