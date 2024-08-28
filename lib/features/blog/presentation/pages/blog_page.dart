import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snakbar.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_details_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static const blogPage = "blog_page";
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(GetAllBlogEvent());
  }

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
        body: BlocConsumer<BlogBloc, BlogBlocState>(
          listener: (context, state) {
            if (state is BlogBlocFailuer) {
              showSnakbar(context, state.errorMessage);
              print("failuer = ${state.errorMessage}");
            }
            // else if (state is DownloadBlogSuccess) {
            //   print("success count= ${state.blogs.length}");
            //   setState(() {});
            // }
          },
          builder: (context, state) {
            if (state is BlogBlocLoading) {
              return const Loader();
            }
            if (state is DownloadBlogSuccess) {
              return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, BlogDetailsPage.blogDetailsPage,
                          arguments: state.blogs[index]);
                    },
                    child: BlogCard(
                      blog: state.blogs[index],
                    ),
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
