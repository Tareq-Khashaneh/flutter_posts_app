import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'features/core/injection.dart' ;
import 'features/posts/presentation/provider/posts_provider.dart';
import 'features/posts/presentation/screens/posts_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DI.init();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PostsProvider(
              DI.getPostsUseCase, DI.addPostUseCase),
        ),
        // PostDetailsProvider created dynamically when navigating
      ],
      child: ScreenUtilInit(

        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
          builder: (_, child) {
          return MaterialApp(

            debugShowCheckedModeBanner: false,
            home: PostsScreen(),
          );
          },
      ),
    );
  }
}
