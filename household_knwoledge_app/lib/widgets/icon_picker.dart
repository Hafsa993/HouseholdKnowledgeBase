import 'package:flutter/material.dart';

class IconPicker extends StatelessWidget {
  static List<IconData> icons = [
    Icons.abc,
    Icons.ac_unit,
    Icons.access_alarm,
    Icons.access_time,
    Icons.accessibility,
    Icons.accessible,
    Icons.account_balance,
    Icons.account_balance_wallet,
    Icons.account_box,
    Icons.ad_units,
    Icons.add,
    Icons.adf_scanner,
    Icons.agriculture,
    Icons.air,
    Icons.airline_seat_flat,
    Icons.airline_seat_recline_normal,
    Icons.airport_shuttle,
    Icons.align_horizontal_left,
    Icons.align_vertical_bottom,
    Icons.inbox,
    Icons.route,
    Icons.email,
    Icons.anchor,
    Icons.apartment,
    Icons.architecture,
    Icons.assignment_rounded,
    Icons.attach_file,
    Icons.attach_money,
    Icons.audiotrack,
    Icons.delete,
    Icons.backpack,
    Icons.bakery_dining_rounded,
    Icons.bathtub_rounded,
    Icons.beach_access,
    Icons.bed,
    Icons.blender,
    Icons.build,
    Icons.cake,
    Icons.calendar_month,
    Icons.call,
    Icons.camera,
    Icons.celebration,
    Icons.chair,
    Icons.checkroom,
    Icons.child_friendly,
    Icons.cleaning_services,
    Icons.church,
    Icons.close,
    Icons.cloud_outlined,
    Icons.coffee,
    Icons.content_cut,
    Icons.cottage,
    Icons.countertops,
    Icons.create_rounded,
    Icons.desktop_mac_rounded,
    Icons.dinner_dining,
    Icons.directions_boat,
    Icons.directions_bus,
    Icons.directions_car,
    Icons.directions_railway,
    Icons.directions_run_outlined,
    Icons.discount,
    Icons.done,
    Icons.downhill_skiing,
    Icons.emoji_emotions,
    Icons.emoji_events,
    Icons.emoji_objects_outlined,
    Icons.explore,
    Icons.extension,
    Icons.face,
    Icons.face_4,
    Icons.family_restroom,
    Icons.fastfood,
    Icons.favorite,
    Icons.filter_hdr,
    Icons.filter_vintage,
    Icons.fitness_center,
    Icons.flatware,
    Icons.flight,
    Icons.folder,
    Icons.forest,
    Icons.fork_right,
    Icons.format_paint,
    Icons.fort,
    Icons.forum,
    Icons.golf_course,
    Icons.grade,
    Icons.grass,
    Icons.groups_2,
    Icons.handyman,
    Icons.headphones,
    Icons.healing,
    Icons.hiking,
    Icons.home,
    Icons.home_repair_service,
    Icons.hotel,
    Icons.ice_skating,
    Icons.icecream_outlined,
    Icons.inventory,
    Icons.iron_outlined,
    Icons.kayaking,
    Icons.kebab_dining,
    Icons.key,
    Icons.keyboard,
    Icons.keyboard_voice,
    Icons.local_bar,
    Icons.local_florist,
    Icons.local_fire_department_outlined,
    Icons.local_grocery_store_outlined,
    Icons.local_laundry_service,
    Icons.local_mall,
    Icons.local_shipping,
    Icons.lock,
    Icons.luggage,
    Icons.menu_book,
    Icons.message,
    Icons.mosque,
    Icons.movie,
    Icons.museum,
    Icons.newspaper,
    Icons.notifications,
    Icons.outdoor_grill,
    Icons.pedal_bike,
    Icons.moped,
    Icons.pest_control,
    Icons.pest_control_rodent,
    Icons.pets,
    Icons.phishing,
    Icons.photo_camera,
    Icons.piano,
    Icons.psychology,
    Icons.report_problem,
    Icons.self_improvement,
    Icons.send,
    Icons.sick,
    Icons.square_foot,
    Icons.two_wheeler,
    Icons.videogame_asset,
    Icons.wallet_giftcard,
    Icons.water,
    // all the icons you want to include
  ];

  const IconPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      children: <Widget>[
        for (var icon in icons)
          GestureDetector(
            onTap: () => Navigator.pop(context, icon),
            child: Icon(icon, size: 30,),
          )
      ],
    );
  }
}