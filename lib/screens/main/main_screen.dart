import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:testovoecz/screens/favorites/favorites_screen.dart';
import 'package:testovoecz/screens/main/main_screen_vm.dart';
import 'package:testovoecz/screens/widgets/custom_appbar.dart';
import 'package:testovoecz/themes/app_colors.dart';
import 'package:testovoecz/themes/text_styles.dart';
import 'package:testovoecz/ui/app_images.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainScreenViewModel viewModel = MainScreenViewModel();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          null,
          IconButton(
            icon: SvgPicture.asset(AppImages.button),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              );
            },
          ),
          'GitHub repos list'),
      body: SafeArea(
        child: ChangeNotifierProvider<MainScreenViewModel>(
          create: (_) => viewModel..init(),
          child: viewModel.selector<MainScreenViewModel, bool?>(
            selector: () => viewModel.isRepoLoading,
            builder: (ctx, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    customTextField(context, focusNode: _focusNode),
                    const SizedBox(height: 16),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          viewModel.allRepo.isEmpty
                              ? 'Search History'
                              : 'What we have found',
                          style: TextStyles.mainBlue,
                        )),
                    viewModel.selector<MainScreenViewModel, bool?>(
                        selector: () => viewModel.allRepo.isNotEmpty,
                        builder: (ctx, _) {
                          return viewModel.allRepo.isNotEmpty
                              ? (viewModel.isRepoLoading)
                                  ? const CircularProgressIndicator(
                                      color: AppColors.accentPrimaryBase,
                                    )
                                  : Expanded(
                                      child: SingleChildScrollView(
                                        physics: const ScrollPhysics(),
                                        child: Column(
                                          children: <Widget>[
                                            ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  viewModel.allRepo.length,
                                              itemBuilder: (context, index) {
                                                final repo =
                                                    viewModel.allRepo[index];

                                                return viewModel.selector<
                                                        MainScreenViewModel,
                                                        bool?>(
                                                    selector: () => viewModel
                                                        .allRepo[index]
                                                        .isFavorite,
                                                    builder: (ctx, _) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0),
                                                        child: ListTile(
                                                          tileColor:
                                                              AppColors.layer1,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          title: Text(
                                                              repo.repoName ??
                                                                  ''),
                                                          trailing: IconButton(
                                                            icon: SvgPicture
                                                                .asset(
                                                              repo.isFavorite
                                                                  ? AppImages
                                                                      .favoriteActive
                                                                  : AppImages
                                                                      .favoriteInactive,
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                viewModel
                                                                    .toggleFavorite(
                                                                        repo);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                              : viewModel.history != null &&
                                      viewModel.history!.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: viewModel.history?.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: ListTile(
                                              tileColor: AppColors.layer1,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              title: Text(
                                                  viewModel.history?[index] ??
                                                      ''),
                                              trailing: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: SvgPicture.asset(
                                                    AppImages.favoriteActive),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(top: 100.0),
                                      child: Text(
                                        'You have empty history.\nClick on search to start journey!',
                                        style: TextStyles.bodyHint,
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                        }),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  SizedBox customTextField(
    BuildContext context, {
    required FocusNode? focusNode,
    void Function(String)? onFieldSubmitted,
    bool isPasswordField = false,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        focusNode: focusNode,

        onFieldSubmitted: onFieldSubmitted,
        style: TextStyles.body,
        //onChanged: viewModel.searchRepositories,
        controller: viewModel.searchController,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.accentPrimaryBase,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          hoverColor: Colors.deepPurpleAccent,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          helperText: '',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onPressed: () {
                  viewModel.searchController.clear();
                  viewModel.clearRepositories();
                },
                icon: SvgPicture.asset(AppImages.close)),
          ),
          prefixIcon: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onPressed: () {
                viewModel.searchRepositories(viewModel.searchController.text);
              },
              icon: SvgPicture.asset(AppImages.search)),
          fillColor: focusNode!.hasFocus
              ? AppColors.accentSecondary02
              : AppColors.layer1,
          filled: true,
          hintText: 'Search',
          hintStyle: TextStyles.bodyHint,
        ),
      ),
    );
  }
}
