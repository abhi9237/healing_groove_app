import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:custom_image_view/custom_image_view.dart';
import 'package:healing/controller/usercontroller/view_detail_controller.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';

import '../../../../../common/common_methods.dart';
import '../../../../model/common/packages_model.dart';
import '../../../../model/common/service_model.dart';

class ViewDetailPrograms extends StatelessWidget {
  final ViewDetailController controller;
  const ViewDetailPrograms({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final doc = controller.centerDetail;
    final packages = controller.centerProgramDetail.packages ?? [];
    final hasPackages = packages.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Healing Programs',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
              if (hasPackages && packages.length > 2)
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'View All',
                        style: TextStyle(
                          color: ColorConstant.appColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: ColorConstant.appColor,
                        size: 16,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Horizontal scrolling program list with fixed height 400
        SizedBox(
          height: 400,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: packages.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final PackagesModel packageData = packages[index];
              final String imageUrl =
                  packageData.image?.url ??
                  (packageData.center?.image?.url ??
                      (doc.gallery != null && doc.gallery!.isNotEmpty
                          ? (doc.gallery!.first.url ?? '')
                          : ''));

              return ProgramCardItem(
                onTap: ()=> controller.onTapBookNow(context,packageData),
                packageData: packageData,
                doctors: packageData.doctors?.length,
                imagePath: imageUrl.isNotEmpty ? imageUrl : '',
                description: packageData.description ?? '',
                title: packageData.name ?? '',
                duration: '${packageData.duration ?? 5} days',
                servicesCount: '${packageData.services?.length ?? 0} services',
                doctorCount: '${packageData.doctors?.length ?? 1} doctor',
                price: controller.calculateServicePrice(
                  packageData.services ?? [],
                ),
                isBestseller: index == 0,
                includedServices: packageData.services,
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProgramCardItem extends StatefulWidget {
  final String imagePath;
  final String description;
  final String title;
  final String duration;
  final String servicesCount;
  final String doctorCount;
  final String price;
  final bool isBestseller;
  final dynamic includedServices;
  final String? doctorName;
  final String? doctorDetails;
  final int? doctors;
  final VoidCallback? onTap;
  final PackagesModel? packageData;

  const ProgramCardItem({
    super.key,
    required this.imagePath,
    required this.description,
    required this.title,
    required this.duration,
    required this.servicesCount,
    required this.doctorCount,
    required this.price,
    required this.isBestseller,
    this.includedServices,
    this.doctorName,
    this.doctorDetails,
    this.doctors,
    this.onTap,
    this.packageData,
  });

  @override
  State<ProgramCardItem> createState() => _ProgramCardItemState();
}

class _ProgramCardItemState extends State<ProgramCardItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: !_isExpanded
          ? _buildCollapsedCard(context)
          : _buildExpandedCard(context),
    );
  }

  Widget _buildCollapsedCard(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCollapsedHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category & Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child:
                          // Title
                          Text(
                            widget.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.lightBlackColor,
                              height: 1.2,
                            ),
                          ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Starting from',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          widget.price,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.appColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Text(
                  widget.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.greyColor,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),

                // Features Row
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey.shade600,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.duration,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    Row(
                      children: [
                        Icon(
                          Icons.shield_outlined,
                          color: Colors.grey.shade600,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.servicesCount,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    Row(
                      children: [
                        Icon(
                          Icons.people_outline_rounded,
                          color: Colors.grey.shade600,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.doctorCount,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // View Detail Button (Collapsed)
                InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded = true;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: ColorConstant.appColor,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'View Detail',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.appColor,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),
                // Action Buttons Row (Book Now & Enquire)
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          onPressed: widget.onTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.appColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Book Now',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: OutlinedButton(
                          onPressed: () {
                            final detailController = Get.find<ViewDetailController>();
                            context.push(
                              RouteConstant.enquireNow,
                              extra: {
                                'center': detailController.centerDetail,
                                'packages': detailController.centerProgramDetail.packages,
                                'selectedPackage': widget.packageData,
                              },
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: ColorConstant.appColor,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Enquire',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.appColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Fixed Section: Compact Header, Hide Details, Action Buttons
        _buildExpandedHeader(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hide details Button
              InkWell(
                onTap: () {
                  setState(() {
                    _isExpanded = false;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: ColorConstant.appColor,
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Hide details',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.appColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Action Buttons Row (Book Now & Enquire)
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: ElevatedButton(
                        onPressed: widget.onTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.appColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: OutlinedButton(
                        onPressed: () {
                          final detailController = Get.find<ViewDetailController>();
                          context.push(
                            RouteConstant.enquireNow,
                            extra: {
                              'center': detailController.centerDetail,
                              'packages': detailController.centerProgramDetail.packages,
                              'selectedPackage': widget.packageData,
                            },
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: ColorConstant.appColor,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Enquire',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.appColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Divider(color: Colors.grey.shade200, height: 1),
            ],
          ),
        ),

        // Scrollable Section: Included Services & Associated Doctors in ONE single list
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // INCLUDED SERVICES Section
                if (widget.includedServices.length > 0)
                  Text(
                    'INCLUDED SERVICES',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                      letterSpacing: 0.5,
                    ),
                  ),
                const SizedBox(height: 8),
                _buildIncludedServicesList(),

                const SizedBox(height: 12),

                // ASSOCIATED DOCTORS Section]
                if ((widget.doctors ?? 0) > 0)
                  Text(
                    'ASSOCIATED DOCTORS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                      letterSpacing: 0.5,
                    ),
                  ),
                const SizedBox(height: 8),
                if ((widget.doctors ?? 0) > 0) _buildDoctorCard(),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildCollapsedHeader() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child:
              widget.imagePath.startsWith('http://') ||
                  widget.imagePath.startsWith('https://')
              ? CustomImageView(
                  url: widget.imagePath,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Image.asset(
                    ImageConstant.imageNotFound,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  widget.imagePath,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
        if (widget.isBestseller)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Text(
                'BESTSELLER',
                style: TextStyle(
                  color: ColorConstant.appColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildExpandedHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Small thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child:
                widget.imagePath.startsWith('http://') ||
                    widget.imagePath.startsWith('https://')
                ? CustomImageView(
                    url: widget.imagePath,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Image.asset(
                      ImageConstant.imageNotFound,
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(
                    widget.imagePath,
                    height: 65,
                    width: 65,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 10),

          // Title & Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightBlackColor,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey.shade600,
                      size: 13,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      widget.duration,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.shield_outlined,
                      color: Colors.grey.shade600,
                      size: 13,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      widget.servicesCount,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(
                      Icons.people_outline_rounded,
                      color: Colors.grey.shade600,
                      size: 13,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      widget.doctorCount,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),

          // FROM / Price / per person
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'FROM',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.appColor,
                ),
              ),
              Text(
                'per person',
                style: TextStyle(fontSize: 9, color: Colors.grey.shade500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIncludedServicesList() {
    List<Map<String, String>> items = [];
    if (widget.includedServices is List<ServiceModel>) {
      for (var s in (widget.includedServices as List<ServiceModel>)) {
        items.add({
          'title': s.name ?? '',
          'subtitle': s.description ?? 'Included in program session',
        });
      }
    } else if (widget.includedServices is List<String>) {
      for (var s in (widget.includedServices as List<String>)) {
        items.add({'title': s, 'subtitle': 'Included in program session'});
      }
    } else if (widget.includedServices is List<Map<String, String>>) {
      items = widget.includedServices as List<Map<String, String>>;
    } else {
      items = [
        {'title': 'New Test HighGeenw', 'subtitle': 'eeeee'},
        {
          'title': 'Yoga and Pranayama Session',
          'subtitle': 'Guided breathing and mobility session',
        },
      ];
    }

    return Column(
      children: items.map((service) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: ColorConstant.appColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service['title'] ?? '',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    if (service['subtitle']?.isNotEmpty == true) ...[
                      const SizedBox(height: 2),
                      Text(
                        service['subtitle']!,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDoctorCard() {
    final String name = widget.doctorName ?? 'Dr. Karan';
    final String details =
        widget.doctorDetails ?? 'BAMS, PG Diploma in Panchakarma • 5 yrs exp';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFFEBF5F0),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.people_outline_rounded,
              color: ColorConstant.appColor,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightBlackColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  details,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
