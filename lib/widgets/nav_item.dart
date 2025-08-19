import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location == '/about') return 1;
    if (location == '/projects') return 2;
    if (location == '/contact') return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _getSelectedIndex(context);
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    final menuItems = [
      {'title': "Home", 'route': "/", 'index': 0, 'icon': Icons.home},
      {'title': "About", 'route': "/about", 'index': 1, 'icon': Icons.person},
      {
        'title': "Projects",
        'route': "/projects",
        'index': 2,
        'icon': Icons.work,
      },
      {
        'title': "Contact",
        'route': "/contact",
        'index': 3,
        'icon': Icons.email,
      },
    ];

    Widget menu = isMobile
        ? Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.amber, size: 30),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          )
        : Row(
            children: menuItems
                .map(
                  (item) => _NavItem(
                    title: item['title'] as String,
                    isActive: selectedIndex == item['index'],
                    onTap: () => context.go(item['route'] as String),
                    icon: item['icon'] as IconData,
                  ),
                )
                .toList(),
          );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 12 : 20,
      ),
      decoration: BoxDecoration(
        color: Colors.indigo[900],
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "MyPortfolio",
            style: TextStyle(
              color: Colors.amber,
              fontSize: isMobile ? 20 : 26,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          menu,
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final IconData icon;

  const _NavItem({
    required this.title,
    required this.isActive,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          color: isActive ? Colors.amber[300] : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.6),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.indigo : Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.indigo : Colors.white,
                fontSize: 18,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveScaffoldWrapper extends StatelessWidget {
  final Widget body;
  const ResponsiveScaffoldWrapper({required this.body, super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(endDrawer: _buildRightSideDrawer(context), body: body);

  Widget _buildRightSideDrawer(BuildContext context) {
    // final location = GoRouterState.of(context).uri.toString();
    final width = MediaQuery.of(context).size.width * 0.8;
    final drawerWidth = width > 350 ? 350.0 : width;

    final menuItems = [
      {'title': "Home", 'route': "/", 'icon': Icons.home},
      {'title': "About", 'route': "/about", 'icon': Icons.person},
      {'title': "Projects", 'route': "/projects", 'icon': Icons.work},
      {'title': "Contact", 'route': "/contact", 'icon': Icons.email},
    ];

    return Drawer(
      child: Container(
        width: drawerWidth,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff4F47C2), Color(0xffA991D4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              CircleAvatar(
                radius: 40,
                backgroundImage: const AssetImage('assets/profile.jpg'),
                backgroundColor: Colors.white.withOpacity(0.3),
              ),
              const SizedBox(height: 16),
              Text(
                "John Doe",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.amber[300],
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 24),
              Divider(
                color: Colors.white24,
                thickness: 1,
                indent: 24,
                endIndent: 24,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: menuItems.map((item) {
                    final location = GoRouterState.of(context).uri.toString();
                    final isSelected = location == item['route'];
                    return ListTile(
                      leading: Icon(
                        item['icon'] as IconData,
                        color: isSelected ? Colors.amber : Colors.white,
                      ),
                      title: Text(
                        item['title'] as String,
                        style: TextStyle(
                          color: isSelected ? Colors.amber : Colors.white,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 18,
                        ),
                      ),
                      selected: isSelected,
                      selectedTileColor: Colors.amber.withOpacity(0.15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        if (!isSelected) {
                          context.go(item['route'] as String);
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
              Divider(
                color: Colors.white24,
                thickness: 1,
                indent: 24,
                endIndent: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  "© 2025 MyPortfolio",
                  style: TextStyle(color: Colors.amber[200], fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
