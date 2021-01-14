import 'package:flutter/material.dart';
import 'page.dart';
import 'package:vrender/vrender.dart';

part 'page_c.view.dart';

class PageC extends VPage {
  VO<int> numberA = VO(1);
  VO<int> numberB = VO(1);
  PageC() {
    title = "视图控制分离";
  }

  void addA() {
    numberA.set(numberA.v + 1);
  }

  void addB() {
    numberB.set(numberB.v + 1);
  }

  @override
  Widget buildView(BuildContext context) {
    return cPageView(this);      
  }
}