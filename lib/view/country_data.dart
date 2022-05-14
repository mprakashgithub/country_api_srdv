import 'package:flutter/material.dart';
import 'package:srdv_task/model/country_data_model.dart';
import 'package:srdv_task/network/api_call.dart';
import 'package:srdv_task/view/search_state_data.dart';
import 'package:srdv_task/view/state_data.dart';

class CountryData extends StatefulWidget {
  const CountryData({Key? key}) : super(key: key);

  @override
  State<CountryData> createState() => _CountryDataState();
}

class _CountryDataState extends State<CountryData> {
  CountryDataModel? countryData;
  bool isLoaded = false;

  getData() async {
    countryData = await ApiCall().getCountryData();

    if (countryData != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  String searchString = "";

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Country Data")),
        body: isLoaded == true
            ? Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchString = value.toLowerCase();
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: countryData!.result!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return countryData!.result![index].countryName!
                                .toLowerCase()
                                .contains(searchString)
                            ? ListTile(
                                onTap: () {
                                  var cId =
                                      countryData!.result![index].countryId!;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              SearchStateData(
                                                  countryId: cId))));
                                },
                                title: Text(
                                    countryData!.result![index].countryName!),
                              )
                            : Container();
                      },
                    ),
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()));
  }
}
