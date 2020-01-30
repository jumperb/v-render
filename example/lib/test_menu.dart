import 'menu_page.dart';
import 'page_a.dart';
import 'page_b.dart';
import 'page_c.dart';
import 'page.dart';

class TestMenu extends MenuPage {  
  TestMenu(): super() {
    title = "v-render demo";
    addCase("数据绑定", (){
      this.routeTo(PageA());
    });
    addCase("定义组件", (){
      this.routeTo(PageB());
    });
    addCase("视图控制分离", (){
      this.routeTo(PageC());
    });
  }
}