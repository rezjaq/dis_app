import 'package:dis_app/controllers/user_controller.dart';
import 'package:dis_app/pages/bank/editBank_screen.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dis_app/blocs/user/user_bloc.dart';
import 'package:dis_app/blocs/user/user_event.dart';
import 'package:dis_app/blocs/user/user_state.dart';

class BankAccountDetailScreen extends StatelessWidget {
  final String id;
  bool _isChange = false;

  BankAccountDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(userController: UserController())..add(GetBankEvent(id: id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bank Account Detail', style: TextStyle(fontSize: DisSizes.fontSizeMd, fontWeight: FontWeight.bold),),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, _isChange);
            },
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserSuccess) {
              final account = state.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Account Detail',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: DisColors.success,
                                  ),
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => EditBankAccountScreen(
                                          id: id,
                                          accountName: account['name'],
                                          accountNumber: account['number'],
                                          bankName: account['bank'],
                                        ),)
                                    );
                                    if (result == true) {
                                      BlocProvider.of<UserBloc>(context).add(GetBankEvent(id: id));
                                      _isChange = true;
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: DisColors.error,
                                  ),
                                  onPressed: () {
                                    _showDeleteConfirmation(context);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Account Name',
                          style: TextStyle(
                            fontSize: 14,
                            color: DisColors.darkerGrey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          account['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Account Number',
                          style: TextStyle(
                            fontSize: 14,
                            color: DisColors.darkerGrey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          account['number'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Bank Name',
                          style: TextStyle(
                            fontSize: 14,
                            color: DisColors.darkerGrey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          account['bank'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is UserFailure) {
              return Center(child: Text('Failed to load account details'));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Bank Account?'),
          content: const Text(
            'Are you sure want to delete this bank account?',
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: DisColors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<UserBloc>(context).add(DeleteBankEvent(id: id));
                Navigator.pop(context);
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: DisColors.error),
              ),
            ),
          ],
        );
      },
    );
  }
}