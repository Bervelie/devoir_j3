import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Fake Database
class FakeDatabase {
  static Map<String, String> users = {
    "bervelie@gmail.com": "12345678"
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VERSALUX',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const Paran1(),
    );
  }
}


//ekran logo a kp afiche 5 sec
class Paran1 extends StatefulWidget {
  const Paran1({super.key});

  @override
  State<Paran1> createState() => _Ekran1State();
}

class _Ekran1State extends State<Paran1> {

  @override
  void initState() {
    super.initState();
    //dire logo a dwe afiche pou l voye nn login ekran
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginEkran()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( 
        child: Stack(
          alignment: Alignment.topLeft,
        children: [ 
        Image.asset('assets/logo.jpeg',
        width: 300,
        height:150,
        fit: BoxFit.cover,
      //  name: "VERSALUX",
              //style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Positioned(
              top:20,
              left:40,
             child:Text( "VERSALUX",
            style: TextStyle(
              fontSize:36,
            )
            )
            )
            ]
            )
            )
            );
  }
}

/// loginEkran
class LoginEkran extends StatefulWidget {
  const LoginEkran({super.key});

  @override
  State<LoginEkran> createState() => _LoginEkranState();
}

class _LoginEkranState extends State<LoginEkran> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailField = TextEditingController();
  final TextEditingController passField = TextEditingController();

  void login() {
    if (_formKey.currentState!.validate()) {
      String email = emailField.text.trim();
      String password = passField.text.trim();
// kondisyon pou verifye si se login itilizate a chwazi si mail ak pass li okay si yo nn lis nou an
      if (FakeDatabase.users.containsKey(email) &&
          FakeDatabase.users[email] == password) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email oubyn password ou rantre a pa bon")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("KONEKTE")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                controller: emailField,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Chan sa obligatwa";
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return "Email ou pa bon retape l";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: passField,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Chan sa obligatwa";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: login,
                child: const Text("Konekte"),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignupPage()),
                  );
                },
                child: const Text("Anrejistre"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//ekran pou anrejistre (Sign up)
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void signup() {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      FakeDatabase.users[email] = password;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kont ou kreye")),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ANREJISTRE")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Antre imel ou";
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return "imel la dwe gne fom @gmail.com";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Antre password";
                  }
                  if (value.length < 8) {
                    return "Modpas la dwe gen 8 karakte";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Konfime Modpas",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != passwordController.text) {
                    return "Password pa bon";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: signup,
                child: const Text("Anrejistre"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//paj Byenvini an
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Akey"),
      ),
      body: const Center(
        child: Text(
          "BYENVINI, Ou nan paj akey VERSALUX !!!!!",
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}