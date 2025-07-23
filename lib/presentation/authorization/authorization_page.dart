import 'package:flutter/material.dart';
import 'package:internet_shop/di/extensions.dart';
import 'package:internet_shop/presentation/theme/extensions.dart';
import 'package:provider/provider.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => context.provider.authorizationService,
      child: _AuthorizationPageState(),
    );
  }
}

class _AuthorizationPageState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthorizationPageContent();
}

class _AuthorizationPageContent extends State<_AuthorizationPageState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _authorizationBody(context));
  }
}

Widget _authorizationBody(BuildContext context) {
  final typography = Theme.of(context).textTheme;
  final colors = Theme.of(context).colorScheme;
  return Container(
    padding: MediaQuery.of(context).padding.copyWith(left: 20, right: 20),
    width: double.infinity,
    child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24),
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              context.strings.authorization,
              style: typography.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  context.strings.authorization_header,
                  style: typography.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: context.strings.email,
                ),
                onChanged: (text) {},
                onSubmitted: (text) {},
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: context.strings.password,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 24),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.onPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 14
                  ),
                ),
                onPressed: () => {},
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    context.strings.login,
                    textAlign: TextAlign.center,
                    style: typography.titleMedium,
                  ),
                )
            ),
          ),
        ),
      ],
    ),
  );
}
