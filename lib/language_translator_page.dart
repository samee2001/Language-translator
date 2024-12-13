import 'package:flutter/material.dart';
import 'package:language_translator/constants/colors.dart';
import 'package:translator/translator.dart';

class LanguageTranslatorPage extends StatefulWidget {
  const LanguageTranslatorPage({super.key});

  @override
  State<LanguageTranslatorPage> createState() => _LanguageTranslatorPageState();
}

class _LanguageTranslatorPageState extends State<LanguageTranslatorPage> {
  var languages = ['Sinhala', 'English', 'Arabic'];
  var originLanguage = 'From';
  var destinationLanguage = ' To';
  var output = ' ';
  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });
    if (src == '--' || dest == '--') {
      setState(() {
        output = 'Fail to Translate';
      });
    }
  }

  String getLanguageCode(String language) {
    if (language == 'English') {
      return 'en';
    } else if (language == 'Sinhala') {
      return 'si';
    } else if (language == 'Arabic') {
      return 'ar';
    } else {
      return '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text(
          "Language Translator",
          style: TextStyle(
            color: kMainFontColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: kDefaultPadding,
                top: kDefaultPadding,
                right: kDefaultPadding),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton(
                      focusColor: kMainFontColor,
                      iconEnabledColor: kMainColor,
                      iconDisabledColor: kMainColor,
                      hint: Text(
                        originLanguage,
                        style: TextStyle(
                          color: kMainFontColor,
                        ),
                      ),
                      dropdownColor: kMainFontColor,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: kMainFontColor,
                      ),
                      items: languages.map((String dropDownStringItem) {
                        return DropdownMenuItem(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          originLanguage = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Icon(
                      Icons.arrow_right_alt_outlined,
                      color: red,
                      size: 40,
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    DropdownButton(
                      focusColor: kMainFontColor,
                      iconEnabledColor: kMainColor,
                      iconDisabledColor: kMainColor,
                      hint: Text(
                        destinationLanguage,
                        style: TextStyle(
                          color: kMainFontColor,
                        ),
                      ),
                      dropdownColor: kMainFontColor,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: kMainFontColor,
                      ),
                      items: languages.map((String dropDownStringItem) {
                        return DropdownMenuItem(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          destinationLanguage = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: kMainFontColor,
                    autofocus: false,
                    style: TextStyle(
                      color: kMainFontColor,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Enter Your Text',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: kMainFontColor,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kMainFontColor,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kMainFontColor,
                          width: 1,
                        ),
                      ),
                      errorStyle: const TextStyle(
                        color: red,
                        fontSize: 15,
                      ),
                    ),
                    controller: languageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Text to Translate';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      translate(
                          getLanguageCode(originLanguage),
                          getLanguageCode(destinationLanguage),
                          languageController.text.toString());
                    },
                    child: const Text(
                      "Translate",
                      style: TextStyle(color: black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "\n$output",
                  style: TextStyle(
                    color: kMainFontColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
