import 'package:animate_do/animate_do.dart';
import 'package:ecommerce_ui_flutter/products/domain/entities/push_message.dart';
import 'package:ecommerce_ui_flutter/products/presentation/providers/nofitications/notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  NotificationsScreenState createState() => NotificationsScreenState();
}

class NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationsProvider).notifications;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final item = notifications[index];
            return _NotificationItem(
              item: item,
            );
          },
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final PushMessage item;
  const _NotificationItem({required this.item});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    
    return GestureDetector(
      onTap: item.data!["id"] != null
          ? () {
              context.push('/product/${item.data!["id"]}');
            }
          : null,
      child: ListTile(
        title: Text(item.title),
        subtitle: Text(item.body),
        leading: item.imageUrl == null
            ? null
            : Image.network(
                item.imageUrl!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Image.asset('assets/1.gif');
                  }
                  return FadeIn(child: child);
                },
              ),
      ),
    );

    // Container(
    //   margin: const EdgeInsets.symmetric(vertical: 10),
    //   decoration: BoxDecoration(
    //     boxShadow: const [
    //       BoxShadow(
    //         color: Color.fromRGBO(50, 50, 93, 0.25),
    //         offset: Offset(0, 13),
    //         blurRadius: 27,
    //         spreadRadius: -5,
    //       ),
    //       BoxShadow(
    //         color: Color.fromRGBO(0, 0, 0, 0.3),
    //         offset: Offset(0, 3),
    //         blurRadius: 16,
    //         spreadRadius: -8,
    //       ),
    //     ],
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   child: Row(
    //     children: [
    //       SizedBox(
    //         width: size.width * 0.3,
    //         child: AspectRatio(
    //           aspectRatio: 1,
    //           child: ClipRRect(
    //             borderRadius: BorderRadius.circular(20),
    //             child: Image.network(
    //               item.imageUrl!,
    //               fit: BoxFit.cover,
    //               loadingBuilder: (context, child, loadingProgress) {
    //                 if (loadingProgress != null) {
    //                   return Image.asset('assets/1.gif');
    //                 }
    //                 return FadeIn(child: child);
    //               },
    //             ),
    //           ),
    //         ),
    //       ),
    //       const SizedBox(width: 20),
    //       SizedBox(
    //         height: size.height * 0.14,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(item.title),
    //             Text(item.body),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
