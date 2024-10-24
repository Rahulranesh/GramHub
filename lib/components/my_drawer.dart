import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/components/my_drawer_tile.dart';
import 'package:socialmedia/cubit/auth_cubit.dart';
import 'package:socialmedia/profile/profile_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              //logo
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Icon(
                  Icons.person_outline,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              //divider line

              Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),

              //home tile
              MyDrawerTile(
                  icon: Icons.home,
                  onTap: () => Navigator.pop(context),
                  title: 'H O M E '),

              //profile tile
              MyDrawerTile(
                  icon: Icons.person,
                  onTap: () {
                    Navigator.pop(context);
                    //get current user
                    final user = context.read<AuthCubit>().currentUser;
                    String? uid = user!.uid;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                            uid: uid,
                          ),
                        ));
                  },
                  title: 'P R O F I L E '),

              //search tile
              MyDrawerTile(
                  icon: Icons.search, onTap: () {}, title: 'S E A R C H'),

              //settings tile
              MyDrawerTile(
                  icon: Icons.settings, onTap: () {}, title: 'S E T T I N G S'),

              //spacer
              Spacer(),

              //logout tile
              MyDrawerTile(
                  icon: Icons.logout,
                  onTap: () {
                    context.read<AuthCubit>().logout();
                  },
                  title: 'L O G O U T'),
            ],
          ),
        ),
      ),
    );
  }
}
