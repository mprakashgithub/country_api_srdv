import 'package:flutter/material.dart';
import 'package:srdv_task/model/state_data_model.dart';
import 'package:srdv_task/network/api_call.dart';
import 'package:srdv_task/view/city_data.dart';

class StateData extends StatefulWidget {
  final countryId;
  StateData({Key? key, this.countryId}) : super(key: key);

  @override
  State<StateData> createState() => _StateDataState();
}

class _StateDataState extends State<StateData> {
  StateDataModel? stateData;
  bool isLoaded = false;

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
        appBar: AppBar(title: Text("State Data")),
        body: isLoaded == true
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: stateData!.result!.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              debugPrint(index.toString());
                              debugPrint(
                                  stateData!.result![index].id.toString());
                              var sId = stateData!.result![index].id;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          CityData(stateId: sId))));
                            },
                            child: Card(
                              child: Container(
                                padding: const EdgeInsets.only(left: 15),
                                height: 40,
                                width: 150,
                                child: Row(
                                  children: [
                                    Text(stateData!.result![index].name
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
