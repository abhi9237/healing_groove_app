import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';

class _ParticipantItem {
  final String name;
  final String age;
  final String gender;
  final String id;

  _ParticipantItem({
    required this.name,
    required this.age,
    required this.gender,
    required this.id,
  });
}

class DetailParticipantsCard extends StatelessWidget {
  final DocModel detailData;

  const DetailParticipantsCard({super.key, required this.detailData});

  @override
  Widget build(BuildContext context) {
    final List<_ParticipantItem> participants = [];
    
    if (detailData.guests != null && detailData.guests!.isNotEmpty) {
      for (var guest in detailData.guests!) {
        participants.add(_ParticipantItem(
          name: guest.fullName ?? 'Guest',
          age: guest.age != null ? '${guest.age} YRS' : 'N/A',
          gender: (guest.gender ?? 'MALE').toUpperCase(),
          id: guest.id != null ? '#${guest.id}' : '',
        ));
      }
    } else {
      participants.add(_ParticipantItem(
        name: detailData.user?.name ?? detailData.user?.email ?? 'Self',
        age: detailData.user?.age != null ? '${detailData.user!.age} YRS' : 'N/A',
        gender: (detailData.user?.gender ?? 'MALE').toUpperCase(),
        id: detailData.userId != null ? '#${detailData.userId}' : '',
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PARTICIPANTS (${participants.length})',
          style: TextStyle(
            fontFamily: 'Afacad',
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: ColorConstant.greyColor.withValues(alpha: 0.8),
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 10),

        // Loop through participants
        ...participants.map((participant) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 46,
                  height: 46,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEDFBF3), // Light mint green background
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person_outline_rounded,
                      color: ColorConstant.appColor,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Participant Details (Name, Age, Gender)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        participant.name,
                        style: const TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: ColorConstant.lightBlackColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          // Age tag
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F4F7),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              participant.age,
                              style: const TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF344054),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            '•',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          const SizedBox(width: 6),
                          // Gender tag
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F4F7),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              participant.gender,
                              style: const TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF344054),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ID Badge on Right
                if (participant.id.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'ID',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: ColorConstant.appColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF3),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFFD0F5E0),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          participant.id,
                          style: const TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: ColorConstant.appColor,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
