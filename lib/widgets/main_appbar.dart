import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:penya_business/colors.dart';

class MainAppbar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppbar({super.key});

  @override
  State<MainAppbar> createState() => _MainAppbarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}

class _MainAppbarState extends State<MainAppbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){},
            icon: Icon(Icons.arrow_back)
        ),
        actions: [
          Text('Already have an account?'),
          GestureDetector(
            onTap: ()=> context.go('/signup'),
            child: Text(
              'Sign In',
              style: TextStyle(
                color: AppColors.accentColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
