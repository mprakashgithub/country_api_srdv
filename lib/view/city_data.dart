import 'package:flutter/material.dart';
import 'package:srdv_task/model/city_data_model.dart';
import 'package:srdv_task/network/api_call.dart';

class CityData extends StatefulWidget {
  final stateId;
  const CityData({Key? key, this.stateId}) : super(key: key);

  @override
  State<CityData> createState() => _CityDataState();
}

class _CityDataState extends State<CityData> {
  CityDataModel? cityData;
  bool isLoaded = false;

  getData() async {
    print(widget.stateId);
    cityData = await ApiCall().getCityData(widget.stateId.toString());

    if (CityData != null) {
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
        appBar: AppBar(title: const Text("City Data")),
        body: isLoaded == true
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: cityData!.result!.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              debugPrint(index.toString());
                              debugPrint(
                                  cityData!.result![index].id.toString());
                            },
                            child: Card(
                              child: Container(
                                padding: const EdgeInsets.only(left: 15),
                                height: 40,
                                width: 150,
                                child: Row(
                                  children: [
                                    Text(cityData!.result![index].name
                                        .toString()),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()));
  }
}
