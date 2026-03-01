import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/profile_header.dart';
import '../widgets/loyalty_points_card.dart';
import '../widgets/account_section_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ProfileHeader(
              name: 'إبراهيم محمد',
              phone: '+966 50 123 4567',
              onEditTapped: () {
                // Navigate to edit profile
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Loyalty Card
                LoyaltyPointsCard(
                  points: 1250,
                  nextReward: 2000,
                  onRedeemTapped: () {},
                ),
                const SizedBox(height: 32),

                // Account Information
                const Text(
                  'حسابي',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkOliveBlack,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      AccountSectionTile(
                        icon: Icons.person_outline,
                        title: 'المعلومات الشخصية',
                        subtitle: 'الاسم، رقم الجوال، البريد الإلكتروني',
                        onTap: () {},
                      ),
                      const Divider(height: 1),
                      AccountSectionTile(
                        icon: Icons.location_on_outlined,
                        title: 'عناويني',
                        subtitle: 'المنزل، العمل',
                        onTap: () {},
                      ),
                      const Divider(height: 1),
                      AccountSectionTile(
                        icon: Icons.payment_outlined,
                        title: 'طرق الدفع',
                        subtitle: 'البطاقات الائتمانية، أبل باي',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Settings & Support
                const Text(
                  'الإعدادات والدعم',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkOliveBlack,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      AccountSectionTile(
                        icon: Icons.language,
                        title: 'اللغة',
                        subtitle: 'العربية',
                        onTap: () {},
                      ),
                      const Divider(height: 1),
                      AccountSectionTile(
                        icon: Icons.notifications_outlined,
                        title: 'الإشعارات',
                        onTap: () {},
                        trailing: Switch(
                          value: true,
                          onChanged: (val) {},
                          activeColor: AppColors.primary,
                        ),
                      ),
                      const Divider(height: 1),
                      AccountSectionTile(
                        icon: Icons.privacy_tip_outlined,
                        title: 'سياسة الخصوصية',
                        onTap: () {},
                      ),
                      const Divider(height: 1),
                      AccountSectionTile(
                        icon: Icons.help_outline,
                        title: 'المساعدة والدعم',
                        onTap: () {},
                      ),
                      const Divider(height: 1),
                      AccountSectionTile(
                        icon: Icons.logout,
                        title: 'تسجيل الخروج',
                        onTap: () {},
                        isDestructive: true,
                        trailing: const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
