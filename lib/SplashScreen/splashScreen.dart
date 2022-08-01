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
    Future.delayed(Duration(milliseconds: 2500), () {
      _abrirTela();
    });
    super.initState();
  }

  _abrirTela() async {
    bool logado = false;
    var prefs = await SharedPreferences.getInstance();

    //COLOCA NA MINHA LIBRARY SESSION OS DADOS NECESSARIOS PARA A SESSAO DO USUARIO
    //PEGA OS DADOS GRAVADOS ANTERIORMENTE NO CACHE DO APK
    try {
      logado = prefs.getBool("loginRealizado")!;
      session.usuarioLogado.email = prefs.getString("email")!;
      session.usuarioLogado.nome = prefs.getString("nome")!;
      session.usuarioLogado.jwtToken = prefs.getString("tokenJwt")!;
    } catch (e) {
      logado = false;
      session.usuarioLogado.email = "";
      session.usuarioLogado.nome = "";
      session.usuarioLogado.jwtToken = "";
    }

    if (logado) {
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
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
            duration: 1500,
            animationDuration: Duration(seconds: 1),
            splashTransition: SplashTransition.fadeTransition,
          ),
        ),
      ],
    );
  }
}
