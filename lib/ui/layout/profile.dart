import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/auth.dart';
import 'package:sultanpos/ui/login/loginpage.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().authState,
      child: Builder(builder: (ctx) {
        return Align(
          alignment: Alignment.center,
          child: PopupMenuButton(
            itemBuilder: (ctx) => [
              _popupMenuItem("setting", "Setting", Icons.settings),
              _popupMenuItem("profile", "Profile", Icons.person),
              _popupMenuItem("logout", "Keluar", Icons.exit_to_app),
            ],
            onSelected: (value) {
              switch (value) {
                case 'setting':
                  AppState().navigateTo('/setting');
                  break;
                case 'profile':
                  AppState().navigateTo('/profile');
                  break;
                case 'logout':
                  {
                    AppState().authState.resetForm();
                    AppState().authState.logout();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(),
                      ),
                    );
                  }
                  break;
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                color: Theme.of(ctx).scaffoldBackgroundColor,
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Text(ctx.select<AuthState, String>((value) => value.user?.name ?? '')),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(Icons.person),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  PopupMenuItem<String> _popupMenuItem(String value, String title, IconData icon) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 8,
          ),
          Text(title)
        ],
      ),
    );
  }
}
