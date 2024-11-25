import 'package:dis_app/blocs/user/user_bloc.dart';
import 'package:dis_app/blocs/user/user_state.dart';
import 'package:dis_app/common/widgets/alertBanner.dart';
import 'package:dis_app/controllers/user_controller.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/user/user_event.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({Key? key}) : super(key: key);

  @override
  _AddBankScreenState createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  String? _bank;

  List<String> _listBank = [
    "BANK BRI",
    "BANK MANDIRI",
    "BANK BNI",
    "BANK BCA",
    "BANK BTN",
    "BANK CIMB NIAGA",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DisColors.white,
      appBar: AppBar(
        title: Text(
          "Add Bank Account",
          style: TextStyle(color: DisColors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        centerTitle: true,
        backgroundColor: DisColors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DisColors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => UserBloc(userController: UserController()),
        child: BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserSuccess) {
                Navigator.pop(context, true);
              }
            },
          child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    if (state is UserSuccess)
                      Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: DisAlertBanner(message: state.message!, color: DisColors.success, icon: Icons.check_circle_outline)
                      ),
                    if (state is UserFailure)
                      Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: DisAlertBanner(message: state.message, color: DisColors.error, icon: Icons.error_outline)
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Full Name Field
                            Text(
                              "Full Name",
                              style: TextStyle(fontSize: 14.0, color: DisColors.textPrimary),
                            ),
                            SizedBox(height: 8.0),
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: "Bank account's name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            // Account Number Field
                            Text(
                              "Account Number",
                              style: TextStyle(fontSize: 14.0, color: DisColors.textPrimary),
                            ),
                            SizedBox(height: 8.0),
                            TextFormField(
                              controller: _numberController,
                              decoration: InputDecoration(
                                hintText: "Add account number",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 16.0),
                            // Bank Name Field
                            Text(
                              "Bank Name",
                              style: TextStyle(fontSize: 14.0, color: DisColors.textPrimary),
                            ),
                            SizedBox(height: 8.0),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              hint: Text("Add bank name"),
                              items: List.generate(_listBank.length, (index) {
                                return DropdownMenuItem(
                                  value: _listBank[index],
                                  child: Text(_listBank[index]),
                                );
                              }),
                              onChanged: (value) {
                                setState(() {
                                  _bank = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Please select a bank";
                                }
                                return null;
                              },
                            ),
                            Spacer(),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<UserBloc>(context).add(AddBankEvent(
                                      bank: _bank!,
                                      name: _nameController.text,
                                      number: _numberController.text,
                                    ));
                                  }
                                  /*showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      title: Column(
                                        children: [
                                          Icon(Icons.check_circle_outline,
                                              color: DisColors.success, size: 85.0),
                                          SizedBox(height: 16.0),
                                          Text("Success!",
                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      content: Text("Your new bank account has been added"),
                                      actions: [
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pushReplacementNamed(
                                                  context, '/BankAccountListScreen');
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: DisColors.primary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            child: Text(
                                              "OK",
                                              style: TextStyle(
                                                color: DisColors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );*/
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: DisColors.primary,
                                  padding: EdgeInsets.symmetric(vertical: 14.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                    color: DisColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}