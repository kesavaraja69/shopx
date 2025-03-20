import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopx/core/theme/app_colors.dart';
import 'package:shopx/core/utils/size_config.dart';
import 'package:shopx/presentation/bloc/Auth/auth_bloc.dart';
import 'package:shopx/presentation/bloc/Category/category_bloc.dart';
import 'package:shopx/presentation/bloc/product/product_bloc.dart';
import 'package:shopx/presentation/screens/auth/login_screen.dart';
import 'package:shopx/presentation/widgets/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List favoriteIndices = [];
  List categorieIndices = [];
  @override
  void initState() {
    super.initState();

    context.read<ProductBloc>().add(FetchProducts());
    context.read<CategoryBloc>().add(FetchCategories());
  }

  void _showLogoutDialog(BuildContext context, onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: Text(
            ' Logout ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          content: Text(
            'Are you sure you want to \n log out?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17.6),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text(
                ' Cancel ',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                ' Logout ',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Sizecf().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SHOPX",
                      style: TextStyle(
                        fontSize: Sizecf.blockSizeHorizontal! * 9.6,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primarycolor,
                      ),
                    ),
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthuLogout) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        }
                      },
                      child: GestureDetector(
                        onTap: () async {
                          _showLogoutDialog(context, () {
                            context.read<AuthBloc>().add(LoginOutEvent());
                          });
                        },
                        child: Column(
                          children: [
                            Icon(Icons.logout_rounded, size: 26),
                            Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: Sizecf.blockSizeHorizontal! * 3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Align(
                  alignment: Alignment.topLeft,
                  child: Customtext(
                    text: 'Categories',
                    size: Sizecf.blockSizeVertical! * 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: Sizecf.scrnHeight! * 0.07,
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoriesLoading) {
                        return Center(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is CategoriesError) {
                        return Center(child: Text(state.message));
                      } else if (state is CategoriesLoaded) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              final categories = state.categories[index];
                              final categoriesf = categorieIndices.contains(
                                index,
                              );
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (categoriesf) {
                                      categorieIndices.remove(index);
                                    } else {
                                      categorieIndices.add(index);
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          categoriesf
                                              ? AppColors.primarycolor
                                              : AppColors.primarylightcolor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Center(
                                        child: Text(
                                          categories,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                categoriesf
                                                    ? AppColors.white
                                                    : AppColors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(child: Text('Categories not found'));
                      }
                    },
                  ),
                ),
                SizedBox(height: 6),
                Align(
                  alignment: Alignment.topLeft,
                  child: Customtext(
                    text: 'Featured products',
                    size: Sizecf.blockSizeVertical! * 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: Sizecf.scrnHeight! * 0.66,
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return Center(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is ProductError) {
                        return Center(child: Text(state.message));
                      } else if (state is ProductLoaded) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 9,
                                  mainAxisSpacing: 9,
                                  childAspectRatio: 0.7,
                                ),
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              final product = state.products[index];
                              final isFavorited = favoriteIndices.contains(
                                index,
                              );
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: Sizecf.scrnHeight! * 0.27,
                                  width: Sizecf.scrnWidth! * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 17,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                    top: Radius.circular(15),
                                                  ),
                                              child: Image.network(
                                                product.image,
                                                height: 120,
                                                width: double.infinity,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 8,
                                            right: 8,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (isFavorited) {
                                                    favoriteIndices.remove(
                                                      index,
                                                    );
                                                  } else {
                                                    favoriteIndices.add(index);
                                                  }
                                                });
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  isFavorited
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color:
                                                      isFavorited
                                                          ? Colors.red
                                                          : Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.title,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize:
                                                    Sizecf
                                                        .blockSizeHorizontal! *
                                                    2.9,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "\$${product.price.toString()}",

                                                  style: TextStyle(
                                                    fontSize:
                                                        Sizecf
                                                            .blockSizeHorizontal! *
                                                        3.7,
                                                    fontWeight: FontWeight.bold,
                                                    overflow: TextOverflow.clip,
                                                    color: const Color.fromARGB(
                                                      255,
                                                      251,
                                                      142,
                                                      0,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  " ★ ${product.rating.rate.toString()}",

                                                  style: TextStyle(
                                                    fontSize:
                                                        Sizecf
                                                            .blockSizeHorizontal! *
                                                        3.5,
                                                    fontWeight: FontWeight.bold,
                                                    overflow: TextOverflow.clip,
                                                    color:
                                                        AppColors.primarycolor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(child: Text('Welcome to Fake Store'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
