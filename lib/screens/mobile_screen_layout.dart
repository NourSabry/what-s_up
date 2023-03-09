import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_up/colors.dart';
import 'package:whats_up/common/utils/utils.dart';
import 'package:whats_up/features/auth/controller/auth_controller.dart';
import 'package:whats_up/features/contacts/screens/select_contact_screen.dart';
import 'package:whats_up/features/chat/widgets/contact_list.dart';
import 'package:whats_up/features/group%20chat/screens/create_group_screen.dart';
import 'package:whats_up/features/status/screens/confirm_status_screen.dart';
import 'package:whats_up/features/status/screens/status_contacts_screen.dart';

class MobileScreenLayout extends ConsumerStatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  ConsumerState<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends ConsumerState<MobileScreenLayout>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabBarController;
  //any observer needs to be addded in initState
  @override
  void initState() {
    //we're only adding this beacuse this is the MobileScreenLayoutState,
    //which is adding a mixin with WidgetsBindingObserver
    WidgetsBinding.instance.addObserver(this);
    tabBarController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final userState = ref.read(authControllerProvider);

    switch (state) {
      case AppLifecycleState.resumed:
        userState.setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        userState.setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "WhatsUp",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.grey,
            ),
            PopupMenuButton(
              icon: const Icon(
                (Icons.more_vert),
                color: Colors.grey,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text("create group"),
                  onTap: () => Future(
                    () => Navigator.pushNamed(
                      context,
                      CreateGroupScreen.routeName,
                    ),
                  ),
                ),
              ],
            )
          ],
          bottom: TabBar(
              controller: tabBarController,
              indicatorColor: tabColor,
              indicatorWeight: 4,
              labelColor: tabColor,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              tabs: const [
                Tab(
                  text: "Chats",
                ),
                Tab(
                  text: "Status",
                ),
                Tab(
                  text: "Calls",
                ),
              ]),
        ),
        body: TabBarView(
          controller: tabBarController,
          children: const [
            ContactList(),
            StatusContactsScreen(),
            Text("Calls"),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (tabBarController.index == 0) {
              Navigator.pushNamed(context, SelectContactsScreen.routeName);
            } else {
              File? pickedImage = await pickImageFromgallery(context);
              if (pickedImage != null) {
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, ConfirmStatusScreen.routeName,
                    arguments: pickedImage);
              } else {}
            }
          },
          backgroundColor: tabColor,
          child: const Icon(
            Icons.comment,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
