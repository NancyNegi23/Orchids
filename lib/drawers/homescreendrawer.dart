import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/login_screen.dart';
import '../commonwidgets/leave_space_widget.dart';
import '../screens/category/category_screen.dart';
import '../screens/homescreen/homescreen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            LeaveSpaceWidget(12),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        "assets/images/logo.png",
                      ),
                    ),
                  ),
                ),
                const Expanded(flex: 5, child: SizedBox())
              ],
            ),
            LeaveSpaceWidget(8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: SizedBox(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        LeaveSpaceWidget(12),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          separatorBuilder: (BuildContext context, int index) {
                            return LeaveSpaceWidget(24);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            final List items = [
                              "Ladies",
                              "Men",
                              "Boys",
                              "Girls",
                              "Home",
                            ];
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
                                          dDescription:
                                              "Get 25 % off on our latest trends",
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
                                } else if (items[index] == "Home") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ));
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  items[index],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        LeaveSpaceWidget(36),
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              FirebaseAuth.instance.signOut().then((value) {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    LoginScreen.routeName, (route) => false);
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Logout',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        LeaveSpaceWidget(32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
