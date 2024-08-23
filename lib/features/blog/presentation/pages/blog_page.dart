import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  static const blogPage = "blog_page";
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppPallete.backgroundColor,
          title: const Text("Blog App"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddNewBlogPage.addNewBlogPage);
              },
              icon: const Icon(CupertinoIcons.add_circled),
            ),
          ],
        ),
        body: const Center(
          child: Text("Body"),
        ),
      ),
    );
  }
}
