import 'package:flutter/material.dart';
import 'page.dart';

class MMenuItem {
  String title;
  Function block;
  MMenuItem(this.title, this.block);
}

class MenuPage extends VPage {
  List<MMenuItem> _items = [];
  MenuPage() {
    title = "菜单";
  }
  void addCase(String title, void block()) {
    _items.add(MMenuItem(title, block));
  }

  Widget buildView(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length * 2,
      itemBuilder: (context, index) {
        if (index.isOdd) {
          return Divider();
        }
        return ListTile(
          title: Text(_items[index~/2].title),          
          onTap: (){
            _items[index~/2].block();
          }
        );
      },
    );
  }
  
}