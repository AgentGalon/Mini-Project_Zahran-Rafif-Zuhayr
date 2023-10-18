import 'package:flutter/material.dart';

class RecomendCard extends StatefulWidget {
  const RecomendCard({Key? key}) : super(key: key);

  @override
  State<RecomendCard> createState() => _RecomendCardState();
}

class _RecomendCardState extends State<RecomendCard> {
  List<Map<String, dynamic>> recmcard = [
    {
      "image": "assets/images/carwash_1.png",
      "shop": "Cube Car Service",
      "location": "Kondotty",
      "review": "5.5",
      "offer": "30%"
    },
    {
      "image": "assets/images/carwash_1.png",
      "shop": "Abc Car Service",
      "location": "Malappuram",
      "review": "2.5",
      "offer": "40%"
    },
    {
      "image": "assets/images/carwash_1.png",
      "shop": "sq Car Service",
      "location": "Kottakkal",
      "review": "4",
      "offer": "10%"
    },
    {
      "image": "assets/images/carwash_1.png",
      "shop": "Cube Car Service",
      "location": "Malappuram",
      "review": "5",
      "offer": "50%"
    },
    {
      "image": "assets/images/carwash_1.png",
      "shop": "Cube Car Service",
      "location": "Malappuram",
      "review": "2.4",
      "offer": "20%"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      // shrinkWrap: true,
      // scrollDirection: Axis.vertical,
      itemBuilder: ((context, index) {
        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 203, 202, 202),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                height: 80,
                width: 80,
                image: AssetImage(recmcard[index]["image"]),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    recmcard[index]["shop"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_city),
                      Text(
                        recmcard[index]["location"],
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(recmcard[index]["review"]),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Text(
                recmcard[index]["offer"] + " off",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                  fontSize: 18,
                ),
              )
            ],
          ),
        );
      }),
      itemCount: recmcard.length,
    );
  }
}
