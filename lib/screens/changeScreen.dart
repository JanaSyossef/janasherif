import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  RegExp upperCaseRegex = RegExp(r'(?=.*[A-Z])');
  RegExp lowerCaseRegex = RegExp(r'(?=.*[a-z])');
  RegExp digitRegex = RegExp(r'(?=.*?[0-9])');
  RegExp specialCharRegex = RegExp(r'(?=.?[!@#\$&~])');
  RegExp lengthRegex = RegExp(r'.{8,}');

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isPasswordValid = false;
  bool passwordsMatch = false;
  bool newpasswordsMatch = false;
  bool obscureNewPassword = true;
  bool obscureOldPassword = true;
  bool obscureConfirmPassword = true;
  var upperCaseCheckbox = false;
  var lowerCaseCheckbox = false;
  var digitCheckbox = false;
  var specialCharCheckbox = false;
  var lengthCheckbox = false;
  void _validatePasswords(String controler) {
    setState(() {
      bool isValid = upperCaseRegex.hasMatch(controler) &&
          lowerCaseRegex.hasMatch(controler) &&
          digitRegex.hasMatch(controler) &&
          specialCharRegex.hasMatch(controler) &&
          lengthRegex.hasMatch(controler);

      upperCaseCheckbox = upperCaseRegex.hasMatch(controler);
      lowerCaseCheckbox = lowerCaseRegex.hasMatch(controler);
      digitCheckbox = digitRegex.hasMatch(controler);
      specialCharCheckbox = specialCharRegex.hasMatch(controler);
      lengthCheckbox = lengthRegex.hasMatch(controler);
      newpasswordsMatch = isValid;
      passwordsMatch =
          newPasswordController.text == confirmPasswordController.text;
    });
  }

  void _toggleObscurePassword(int fieldIndex) {
    setState(() {
      if (fieldIndex == 0) {
        obscureNewPassword = !obscureNewPassword;
      } else if (fieldIndex == 1) {
        obscureConfirmPassword = !obscureConfirmPassword;
      } else if (fieldIndex == 3) {
        obscureOldPassword = !obscureOldPassword;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Change Password'),
          leading: Icon(Icons.arrow_back),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Change Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: oldPasswordController,
                      obscureText: obscureOldPassword,
                      onChanged: (value) =>
                          _validatePasswords(newPasswordController.text),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Old Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureOldPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () => _toggleObscurePassword(3),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Enter Your New Password',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: newPasswordController,
                      obscureText: obscureNewPassword,
                      onChanged: (value) =>
                          _validatePasswords(newPasswordController.text),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'New Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureNewPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () => _toggleObscurePassword(0),
                        ),
                        errorText: newpasswordsMatch
                            ? null
                            : 'Password does not meet criteria',
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: upperCaseCheckbox ? Colors.green : Colors.grey,
                    ),
                    const Text(
                      'Should contain at least one uppercase letter',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: lowerCaseCheckbox ? Colors.green : Colors.grey,
                    ),
                    const Text(
                      'Should contain at least one lowercase letter',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: digitCheckbox ? Colors.green : Colors.grey,
                    ),
                    const Text(
                      'Should contain at least one digit',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: specialCharCheckbox ? Colors.green : Colors.grey,
                    ),
                    const Text(
                      'Should contain at least one special character',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: lengthCheckbox ? Colors.green : Colors.grey,
                    ),
                    const Text(
                      'Must be at least 8 characters in length',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: obscureConfirmPassword,
                      onChanged: (value) =>
                          _validatePasswords(newPasswordController.text),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Confirm New Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () => _toggleObscurePassword(1),
                        ),
                        errorText:
                            passwordsMatch ? null : 'Passwords do not match',
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 120),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: passwordsMatch ? Colors.green : Colors.grey,
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(
                      onPressed: () {},
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
