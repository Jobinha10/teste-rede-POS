import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wishes/Home/HomePage.dart';
import 'package:wishes/Login/loginScreen.dart';
import 'package:wishes/theme.dart';
import 'package:wishes/session.dart' as session;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 2700), () {
      _abrirTela();
    });
    super.initState();
  }

  _abrirTela() async {
    var prefs = await SharedPreferences.getInstance();

    //COLOCA NA MINHA LIBRARY SESSION OS DADOS NECESSARIOS PARA A SESSAO DO USUARIO
    //PEGA OS DADOS GRAVADOS ANTERIORMENTE NO CACHE DO APK
    try {
      session.usuarioLogado.nome = prefs.getString("nome")!;
    } catch (e) {
      session.usuarioLogado.nome = "";
    }

    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          decoration: BoxDecoration(gradient: AppTheme.gradientPadrao),
        ),
        Center(
          child: AnimatedSplashScreen(
            backgroundColor: Colors.transparent,
            splash: AppTheme.logo,
            nextScreen: HomeScreen(),
            disableNavigation: true,
            splashIconSize: 86.06,
            duration: 2500,
            splashTransition: SplashTransition.rotationTransition,
          ),
        ),
      ],
    );
  }
}
