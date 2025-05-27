import 'package:bvg_partner/modules/launch/launch_provider.dart';
import 'package:bvg_partner/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../routes/route_const.dart';

class FetchLocation extends StatefulWidget {
  const FetchLocation({super.key});

  @override
  State<FetchLocation> createState() => _FetchLocationState();
}

class _FetchLocationState extends State<FetchLocation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
    Provider.of<LaunchProvider>(context, listen: false).getCurrentAddress();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Consumer<LaunchProvider>(
          builder: (context, provider, child) {
            return FadeTransition(
              opacity: _animation,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  spacing: 10,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (provider.locationStatus == LocationStatus.fetching) ...{
                      Column(
                        spacing: 20,
                        children: [
                          CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                          Text(
                            "Fetching Location",
                            style: TextStyle(
                              fontFamily: AppFonts.themeFont,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    } else ...{
                      Column(
                        spacing: 20,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.black,
                            size: 40,
                          ),
                          Text(
                            provider.currentLocationString,
                            style: TextStyle(
                              fontFamily: AppFonts.themeFont,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),

                          CustomButton(
                            text: "Continue",
                            onTap: () {
                              context.pushNamed(RouteConst.loginScreenRoute);
                            },
                          )
                        ],
                      ),
                    },
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
