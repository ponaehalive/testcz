import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:testovoecz/domain/models/repo_model.dart';
import 'package:testovoecz/screens/favorites/favorites_screen_vm.dart';
import 'package:testovoecz/screens/main/main_screen.dart';
import 'package:testovoecz/screens/main/main_screen_vm.dart';
import 'package:testovoecz/screens/widgets/custom_appbar.dart';
import 'package:testovoecz/themes/app_colors.dart';
import 'package:testovoecz/themes/text_styles.dart';
import 'package:testovoecz/ui/app_images.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  FavoritesScreenViewModel viewModel = FavoritesScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          IconButton(
            icon: SizedBox(
                height: 44,
                width: 44,
                child: SvgPicture.asset(AppImages.backButton)),
            onPressed: () {
              viewModel.clearRepositories();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          ),
          null,
          'Favorite repos list'),

      // backgroundColor: AppColors.mainBackground,
      body: SafeArea(
        child: ChangeNotifierProvider<FavoritesScreenViewModel>(
          create: (_) => viewModel..init(),
          child: viewModel.selector<FavoritesScreenViewModel, bool?>(
            selector: () => viewModel.favoriteRepoNames!.isEmpty,
            builder: (ctx, _) {
              return (viewModel.favoriteRepoNames!.isEmpty)
                  ? Container(
                      color: AppColors.background,
                      child: Center(
                        child: Text(
                          'You have no favorites.\n Click on star while searching to add first favorite',
                          style: TextStyles.bodyHint,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 16.0,
                      ),
                      child: ListView.builder(
                        itemCount: viewModel.favoriteRepoNames?.length,
                        itemBuilder: (context, index) {
                          final repo = viewModel.favoriteRepoNames;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ListTile(
                              tileColor: AppColors.layer1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: Text(repo?[index] ?? ''),
                              trailing: IconButton(
                                icon:
                                    SvgPicture.asset(AppImages.favoriteActive),
                                onPressed: () {
                                  setState(() {
                                    viewModel.removeFavorite(repo![index]);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
