import 'package:dis_app/blocs/user/user_bloc.dart';
import 'package:dis_app/blocs/user/user_event.dart';
import 'package:dis_app/blocs/user/user_state.dart';
import 'package:dis_app/controllers/user_controller.dart';
import 'package:dis_app/pages/bank/addBank_screen.dart';
import 'package:dis_app/pages/bank/bankDetail_screen.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dis_app/utils/constants/colors.dart';

class BankScreen extends StatefulWidget {
  @override
  _BankScreenState createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  late UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = UserBloc(userController: UserController())..add(ListBankEvent());
  }

  void _refresh() {
    _userBloc.add(ListBankEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _userBloc,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: DisColors.white,
            appBar: AppBar(
              title: Text(
                "Bank Account List",
                style: TextStyle(color: DisColors.black, fontWeight: FontWeight.bold, fontSize: DisSizes.fontSizeMd),
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
              actions: state is UserSuccess && (state.data?.length ?? 0) > 0 ? [
                IconButton(
                  icon: Icon(Icons.add, color: DisColors.black),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddBankScreen()),
                    );
                    if (result == true) {
                      _refresh();
                    }
                  },
                ),
              ] : null,
            ),
            body: state is UserSuccess && (state.data?.length ?? 0) == 0
                ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/noBankAccount.svg',
                      height: 200,
                    ),
                    SizedBox(height: 24.0),
                    // Title Text
                    Text(
                      "No Bank Account Linked",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.0),
                    // Subtitle Text
                    Text(
                      "Add a bank account to start withdrawing your commission.",
                      style: TextStyle(
                        fontSize: DisSizes.fontSizeSm,
                        color: DisColors.darkerGrey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddBankScreen()),
                        );
                        if (result == true) {
                          _refresh();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DisColors.primary,
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        "Add Bank Account",
                        style: TextStyle(
                          color: DisColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: DisSizes.fontSizeMd,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : state is UserSuccess && (state.data?.length ?? 0) > 0
                ? ListView.builder(
              itemCount: state.data?['data'].length ?? 0,
              itemBuilder: (context, index) {
                final account = state.data?['data'][index];
                return GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: _userBloc,
                          child: BankAccountDetailScreen(
                            id: account?['_id'] ?? '',
                          ),
                        ),
                      ),
                    );
                    if (result == true) {
                      _refresh();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: DisColors.white,
                      borderRadius: BorderRadius.circular(DisSizes.sm),
                      boxShadow: [
                        BoxShadow(
                          color: DisColors.darkerGrey.withOpacity(0.1),
                          blurRadius: 8.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                      border: Border.all(color: DisColors.grey, width: 1.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (account?['number'] ?? '').toUpperCase(),
                          style: TextStyle(
                            fontSize: DisSizes.fontSizeSm,
                            fontWeight: FontWeight.w500,
                            color: DisColors.darkGrey,
                          ),
                        ),
                        SizedBox(height: DisSizes.xs),
                        Text(
                          (account?['name'] ?? '').toUpperCase(),
                          style: TextStyle(
                            fontSize: DisSizes.fontSizeSm,
                            color: DisColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: DisSizes.xs),
                        Text(
                          (account?['bank'] ?? '').toUpperCase(),
                          style: TextStyle(
                            fontSize: DisSizes.fontSizeSm,
                            color: DisColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
                : state is UserLoading
                ? Center(child: CircularProgressIndicator())
                : Center(child: Text('Failed to load bank accounts')),
          );
        },
      ),
    );
  }
}