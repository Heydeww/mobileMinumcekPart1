import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minum_cekk_app/core/app_colors.dart';
import 'package:minum_cekk_app/core/app_text_styles.dart';

class _NavItem {
  const _NavItem({
    required this.iconPath,
    required this.label,
  });
  final String iconPath;
  final String label;
}

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const List<_NavItem> _items = [
    _NavItem(iconPath: 'assets/icons/ic_home.svg', label: 'Beranda'),
    _NavItem(iconPath: 'assets/icons/ic_scan.svg', label: 'Pindai'),
    _NavItem(iconPath: 'assets/icons/ic_news.svg', label: 'Berita'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: 96,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 96,
              color: colors.primary,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_items.length, (index) {
                final bool isActive = index == currentIndex;
                return _NavItemWidget(
                  item: _items[index],
                  isActive: isActive,
                  activeColor: colors.secondary,
                  activeIconColor: colors.textPrimary,
                  inactiveColor: colors.textSecondary,
                  onTap: () => onTap(index),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItemWidget extends StatelessWidget {
  const _NavItemWidget({
    required this.item,
    required this.isActive,
    required this.activeColor,
    required this.activeIconColor,
    required this.inactiveColor,
    required this.onTap,
  });

  final _NavItem item;
  final bool isActive;
  final Color activeColor;
  final Color activeIconColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, isActive ? -18.0 : 0.0, 0),
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? activeColor : Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: isActive ? Colors.black.withOpacity(0.15) : Colors.transparent,
              blurRadius: 10.0, // Strictly kept at 10.0 to prevent interpolation overshoot issues
              offset: isActive ? const Offset(0, 4) : const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              item.iconPath,
              width: 38,
              height: 38,
              colorFilter: ColorFilter.mode(
                isActive ? activeIconColor : inactiveColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.label,
              style: AppTextStyles.bottomNavText.copyWith(
                color: isActive ? activeIconColor : inactiveColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
