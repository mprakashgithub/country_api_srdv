import 'package:flutter/material.dart';
import 'package:srdv_task/model/country_data_model.dart';
import 'package:srdv_task/model/state_data_model.dart';
import 'package:srdv_task/network/api_call.dart';
import 'package:srdv_task/view/city_data.dart';
import 'package:srdv_task/view/state_data.dart';

class SearchStateData extends StatefulWidget {
  final countryId;
  const SearchStateData({Key? key, this.countryId}) : super(key: key);

  @override
  State<SearchStateData> createState() => _SearchStateDataState();
}

class _SearchStateDataState extends State<SearchStateData> {
  StateDataModel? stateData;
  bool isLoaded = false;
  String searchString = "";

  getData() async {
    print(widget.countryId);
    stateData = await ApiCall().getStateData(widget.countryId.toString());

    if (stateData != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("State Data")),
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
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: stateData!.result!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return stateData!.result![index].name!
                                .toLowerCase()
                                .contains(searchString)
                            ? ListTile(
                                onTap: () {
                                  var sId = stateData!.result![index].id!;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              CityData(stateId: sId))));
                                },
                                title: Text(stateData!.result![index].name!),
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
