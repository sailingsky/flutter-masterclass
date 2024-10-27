import 'package:flutter/material.dart';
import 'package:flutter_masterclass/models/character.dart';
import 'package:flutter_masterclass/models/vocation.dart';
import 'package:flutter_masterclass/screens/create/vocation_card.dart';
import 'package:flutter_masterclass/shared/styled_button.dart';
import 'package:flutter_masterclass/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../../shared/styled_text.dart';
import '../home/home.dart';

var uuid = const Uuid();

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {

  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();
   Vocation _selectedVocation = Vocation.junkie;

  @override
  void dispose() {
    _nameController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  void updateVocation(Vocation vocation){
    setState(() {
      _selectedVocation = vocation;
      print(_selectedVocation.name);
    });
  }
  void handleSubmit(){
    if(_nameController.text.trim().isEmpty){
      showDialog(context: context, builder: (ctx) {
        return AlertDialog(
          title: const StyledHeading('Missing Character Name'),
          content: const StyledText(
              'Every good RPG character needs a great name...'),
          actions: [
            StyledButton(onPressed: () => Navigator.pop(ctx),
                child: const StyledHeading('close'))
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      });

      return;
    }
    if(_sloganController.text.trim().isEmpty) {
      showDialog(context: context, builder: (ctx) {
        return AlertDialog(
          title: const StyledHeading('Missing Slogan'),
          content: const StyledText(
              'Remember add a slogan...'),
          actions: [
            StyledButton(onPressed: () => Navigator.pop(ctx),
                child: const StyledHeading('close'))
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      });
      return;
    }
    characters.add(
     Character(name: _nameController.text.trim(), slogan: _sloganController.text.trim(), vocation: _selectedVocation, id: uuid.v4())
    );
    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const Home(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Create Character'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical:30,horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor,),
              ),
              const Center(
                child: StyledHeading('Welcome new player'),
              ),
              const Center(
                child: StyledText('Create a name & slogan for your character'),
              ),
              const SizedBox(height: 30,),
          
          
          
          
          
              TextField(
                controller: _nameController,
                style:  GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
                cursorColor: AppColors.textColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_2),
                  label: StyledText('Character name')
                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: _sloganController,
                style:  GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
                cursorColor: AppColors.textColor,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.chat),
                    label: StyledText('Slogan')
                ),
              ),
              const SizedBox(height: 30,),
          
              //select vocation title
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor,),
              ),
              const Center(
                child: StyledHeading('Welcome new player'),
              ),
              const Center(
                child: StyledText('Create a name & slogan for your character'),
              ),
          
              //vocation cards
              VocationCard(vocation: Vocation.junkie,onTap: updateVocation,isSelected: _selectedVocation==Vocation.junkie,),
              VocationCard(vocation: Vocation.ninja,onTap: updateVocation,isSelected: _selectedVocation==Vocation.ninja,),
              VocationCard(vocation: Vocation.raider,onTap: updateVocation,isSelected: _selectedVocation==Vocation.raider,),
              VocationCard(vocation: Vocation.wizard,onTap: updateVocation,isSelected: _selectedVocation==Vocation.wizard,),
          
              const SizedBox(height: 30,),
          
              Center(
                child: StyledButton(onPressed: handleSubmit, child: const StyledHeading('Create Character')),
              )
            ],
          ),
        ),
      ),
    );
  }


}
