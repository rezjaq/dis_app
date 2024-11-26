import 'package:dis_app/blocs/user/user_bloc.dart';
import 'package:dis_app/blocs/user/user_event.dart';
import 'package:dis_app/blocs/user/user_state.dart';
import 'package:dis_app/common/widgets/alertBanner.dart';
import 'package:dis_app/controllers/user_controller.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditBankAccountScreen extends StatefulWidget {
  final String id;
  final String accountName;
  final String accountNumber;
  final String bankName;

  const EditBankAccountScreen({
    Key? key,
    required this.id,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
  }) : super(key: key);

  @override
  _EditBankAccountScreenState createState() => _EditBankAccountScreenState();
}

class _EditBankAccountScreenState extends State<EditBankAccountScreen> {
  late TextEditingController _accountNameController;
  late TextEditingController _accountNumberController;
  String? _selectedBankName;

  final List<String> _bankNames = [
    "BANK BRI",
    "BANK MANDIRI",
    "BANK BNI",
    "BANK BCA",
    "BANK BTN",
    "BANK CIMB NIAGA",
  ];

  @override
  void initState() {
    super.initState();
    _accountNameController = TextEditingController(text: widget.accountName);
    _accountNumberController =
        TextEditingController(text: widget.accountNumber);
    _selectedBankName = widget.bankName;
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(userController: UserController()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Bank Account', style: TextStyle(fontSize: DisSizes.fontSizeMd, fontWeight: FontWeight.bold)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body:BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserSuccess) {
              Navigator.pop(context, true);
            }
          },
          child:  BlocBuilder(
              builder: (context, state) {
                return Stack(
                  children: [
                    if (state is UserLoading)
                      const Center(child: CircularProgressIndicator()),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          if (state is UserFailure)
                            DisAlertBanner(message: state.message, color: DisColors.error, icon: Icons.error),
                          if (state is UserSuccess)
                            DisAlertBanner(message: state.message!, color: DisColors.success, icon: Icons.check_circle_outline),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Account Name',
                            style: TextStyle(
                              fontSize: 14,
                              color: DisColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _accountNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Account Number',
                            style: TextStyle(
                              fontSize: 14,
                              color: DisColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _accountNumberController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Bank Name',
                            style: TextStyle(
                              fontSize: 14,
                              color: DisColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: _selectedBankName,
                            items: _bankNames.map((String bankName) {
                              return DropdownMenuItem<String>(
                                value: bankName,
                                child: Text(bankName),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedBankName = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<UserBloc>().add(
                                  UpdateBankEvent(
                                    id: widget.id,
                                    bank: _selectedBankName!,
                                    name: _accountNameController.text,
                                    number: _accountNumberController.text,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: DisColors.primary,
                                foregroundColor: DisColors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                              ),
                              child: const Text(
                                'Save',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}