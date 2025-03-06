import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:orchids/constants.dart';

import '../category/category_screen.dart';

class SaleOfferWidget extends StatelessWidget {
  final List items = [
    "Ladies",
    "Men",
    "Boys",
    "Girls",
  ];

  SaleOfferWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ExpandableNotifier(
          child: ScrollOnExpand(
        child: Card(
          elevation: 0,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: false,
                  hasIcon: false,
                ),
                header: _buildHeader(),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Container _buildHeader() {
    return Container(
      color: kPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4.0,
          vertical: 24,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 10,
              child: Column(children: const [
                Text(
                  "New styles added & further price drops!\nUp to 60% off on sale",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Available on Orchids app & in-store",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ]),
            ),
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  buildList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            if (items[index] == 'Ladies') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(
                      dimage:
                          "https://lp2.hm.com/hmgoepprod?source=url[https://www2.hm.com/content/dam/global_campaigns/season_08/divided/5018f/5018F-1x1-summer-tops.jpg]&scale=size[960]&sink=format[jpeg],quality[80]",
                      dtitle: "We're up for summer",
                      dDescription: "Get 25 % off on our latest trends",
                      cateId: 'NHm74mVCsetP5lm77bIO',
                    ),
                  ));
            } else if (items[index] == "Men") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(
                      cateId: 'tjb89aVfgoey23hn7PP1',
                    ),
                  ));
            } else if (items[index] == "Boys") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(
                      dimage:
                          "https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2F66%2Fa2%2F66a2a0602b6b704a5424a90a18867d4df68da174.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url%5Bfile:/product/main%5D",
                      dtitle: "Kids getaway fashion",
                      dDescription:
                          "Styles your little one needs for a fun vacation",
                      cateId: 'vMigggzKuN3GqObplBFg',
                    ),
                  ));
            } else if (items[index] == "Girls") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(
                      dimage:
                          "https://lp2.hm.com/hmgoepprod?set=width%5B960%5D,quality%5B80%5D,options%5Blimit%5D&source=url%5Bhttps://www2.hm.com/content/dam/global_campaigns/season_08/kids/4127e/4127E-1x1-1.jpg%5D&scale=width%5Bglobal.width%5D,height%5B15000%5D,options%5Bglobal.options%5D&sink=format%5Bjpg%5D,quality%5Bglobal.quality%5D",
                      dtitle: "Their summer style,sorted",
                      dDescription:
                          "Tick off the summer style checklist with the latest staples.",
                      cateId: 'EuWRrOHFucMgq35wTRs9',
                    ),
                  ));
            }
          },
          child: ListTile(
            title: Text(
              items[index],
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            trailing:
                const Icon(Icons.arrow_forward, color: Colors.black, size: 20),
          ),
        );
      },
    );
  }
}
