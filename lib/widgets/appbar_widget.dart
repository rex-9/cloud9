import 'package:cloud9/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dialogs.dart';

LoginController loginController = Get.put(LoginController());

PreferredSize appBarWidget(context, heading, tabs, controller) => PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(heading),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => confirmDialog('Please confirm to Log Out!',
                () => loginController.logout(), context),
          )
        ],
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        titleSpacing: 30,
        elevation: 2,
        bottom: TabBar(
          controller: controller,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2,
              color: Colors.white,
            ),
            insets: EdgeInsets.symmetric(vertical: 7),
          ),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          tabs: tabs,
        ),
      ),
    );
