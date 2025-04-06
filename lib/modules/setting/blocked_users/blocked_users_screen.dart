import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/assets/assets.gen.dart';
import 'package:flutter_whattodayrice/common/widget/app_bar_normal.dart';
import 'package:flutter_whattodayrice/common/widget/app_loading_indicator.dart';
import 'package:flutter_whattodayrice/common/widget/app_snack_bar.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/data/models/profile.dart';
import 'package:flutter_whattodayrice/modules/setting/blocked_users/bloc/blocked_users_bloc.dart';

class BlockedUsersScreen extends StatefulWidget {
  const BlockedUsersScreen({super.key});

  @override
  State<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  @override
  void initState() {
    context.read<BlockedUsersBloc>().add(const BlockedUsersLoadRequested());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlockedUsersBloc, BlockedUsersState>(
      listener: (context, state) {
        if (state is BlockedUsersDeleteSucceed) {
          ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.text(state.message));

          context.read<BlockedUsersBloc>().add(const BlockedUsersLoadRequested());
        }
      },
      child: Scaffold(
        appBar: const AppBarNormal(title: '차단한 계정', centerTitle: true),
        body: BlocBuilder<BlockedUsersBloc, BlockedUsersState>(
          buildWhen: (previous, current) => current is BlockedUsersLoaded,
          builder: (context, state) {
            if (state is! BlockedUsersLoaded) {
              return const Center(child: AppLoadingIndicator());
            }

            if (state.blockedUsers.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '차단한 계정이 없어요.',
                        style: AppTextStyle.bold16.copyWith(color: AppColor.black121212),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '계정을 차단하면, 서로의 글을 볼 수 없어요.',
                    style: AppTextStyle.regular14.copyWith(color: AppColor.gray8C8C8C),
                  ),
                ],
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        '차단한 계정',
                        style: AppTextStyle.bold20.copyWith(color: AppColor.black121212),
                      ),
                    ),
                    Text(
                      '계정을 차단하면 서로의 글을 볼 수 없어요.',
                      style: AppTextStyle.regular14.copyWith(color: AppColor.gray8C8C8C),
                    ),
                    const SizedBox(height: 24),
                    ...List.generate(
                      state.blockedUsers.length,
                      (index) => BlockedUserItem(profile: state.blockedUsers[index], index: index),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BlockedUserItem extends StatelessWidget {
  const BlockedUserItem({super.key, required this.profile, required this.index});

  final int index;
  final BlockedUserProfile profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Assets.images.iconAuthorProfile.svg(),
        const SizedBox(width: 6),
        Text(
          '${profile.nickname}',
          style: AppTextStyle.bold16.copyWith(color: AppColor.black121212),
        ),
        const Spacer(),
        InkWell(
          onTap: () => context.read<BlockedUsersBloc>().add(BlockedUsersDeleteRequested(index: index)),
          child: Text(
            '차단 해제',
            style: AppTextStyle.bold14.copyWith(color: AppColor.black121212),
          ),
        )
      ],
    );
  }
}
