// ignore: file_names
import 'package:flutter/material.dart';
import 'package:vinove_assignemnt/Components/LiveLocation_Page.dart';
import 'package:vinove_assignemnt/Components/LocationHistory_Page.dart';

import 'Global/Person.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Attendance ', style: TextStyle(color: Colors.white)),
        ),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Container(
              color: const Color(0xFF2E7D32).withOpacity(0.12),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop'),
                      ),
                      SizedBox(width: 5),
                      Text('All Members', 
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Change',
                        style: TextStyle(color: Colors.teal, fontSize: 16)),
                  ),
                ],
              ),
            ),
            const DatePickerSection(),
            const Divider(),
            Expanded(
              child: ListView(
                children: const [
                  EmployeeListTile(
                    img: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
                    name: 'Rahul Sharma',
                    id: 'RS1234',
                    isWorking: true,
                    isLogin: true,
                    incoming: '09:00 am',
                    outgoing: '06:00 pm',
                  ),
                  Divider(),
                  EmployeeListTile(
                    img: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
                    name: 'Priya Patel',
                    id: 'PP2342',
                    isWorking: false,
                    isLogin: true,
                    incoming: '09:15 am',
                    outgoing: '06:15 pm',
                  ),
                  Divider(),
                  EmployeeListTile(
                    img: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
                    name: 'Amit Kumar',
                    id: 'AK2345',
                    isWorking: false,
                    isLogin: false,
                    incoming: '09:30 am',
                    outgoing: '06:30 pm',
                  ),
                   Divider(),
                  EmployeeListTile(
                    img: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
                    name: 'Devender Kumar',
                    id: 'DK2345',
                    isWorking: false,
                    isLogin: true,
                    incoming: '09:35 am',
                    outgoing: '04:30 pm',
                  ),
                   Divider(),
                  EmployeeListTile(
                    img: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
                    name: 'Rahul Cjowdhary',
                    id: 'RC2345',
                    isWorking: false,
                    isLogin: false,
                    incoming: '08:30 am',
                    outgoing: '06:30 pm',
                  ),
                   Divider(),
                  EmployeeListTile(
                    img: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
                    name: 'Harish Kumar',
                    id: 'HK2345',
                    isWorking: true,
                    isLogin: true,
                    incoming: '11:30 am',
                    outgoing: '02:30 pm',
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatePickerSection extends StatelessWidget {
  const DatePickerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(Icons.arrow_back_ios_new, color: Colors.grey),
          Text(
            DateTime.now().toString(),
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          const SizedBox(width: 15),
          const Icon(Icons.calendar_today_outlined, color: Colors.grey),
        ],
      ),
    );
  }
}

class EmployeeListTile extends StatelessWidget {
  final String img;
  final String name;
  final String id;
  final bool isLogin;
  final bool isWorking;
  final String outgoing;
  final String incoming;

  const EmployeeListTile({
    required this.img,
    required this.name,
    required this.id,
    required this.isLogin,
    required this.isWorking,
    required this.outgoing,
    required this.incoming,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(img),
              ),
              const SizedBox(width: 10),
              Text(
                "$name ($id)",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          if (isLogin)
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.calendar_month, size: 30),
                  color: Colors.black38,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationHistoryScreen(
                          Person(name, id, "Online", "Delhi NCR", "110001"),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.gps_fixed, size: 25),
                  color: Colors.teal.withOpacity(0.75),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LiveLocationScreen(
                          Person(name, id, "Online", "Delhi NCR", "110001"),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
      subtitle: _buildSubtitle(),
    );
  }

  Widget _buildSubtitle() {
    if (!isLogin) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Text(
          'NOT LOGGED IN YET',
          style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
        ),
      );
    }

    return Row(
      children: [
        const Icon(Icons.call_made, color: Colors.green),
        const SizedBox(width: 4),
        Text(incoming, style: const TextStyle(color: Colors.black)),
        const SizedBox(width: 25),
        if (isWorking) ...[
          const Icon(Icons.warning_rounded, color: Colors.orange, size: 18),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              'WORKING',
              style: TextStyle(
                fontSize: 12,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ] else
          Row(
            children: [
              const Icon(Icons.call_received, color: Colors.red),
              const SizedBox(width: 4),
              Text(outgoing, style: const TextStyle(color: Colors.black)),
            ],
          ),
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 20,
      child: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timelapse_rounded, color: Colors.white, size: 24),
                      SizedBox(width: 10),
                      Text(
                        'workstatus',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
                        ),
                      ),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amit Kumar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'amit.kumar@example.com',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            DrawerListTile(title: 'Timer', icon: Icons.alarm),
            DrawerListTile(title: 'ATTENDANCE', icon: Icons.calendar_month),
            DrawerListTile(title: 'Activity', icon: Icons.auto_graph),
            DrawerListTile(title: 'Timesheet', icon: Icons.developer_board_sharp),
            DrawerListTile(title: 'Report', icon: Icons.dashboard),
            DrawerListTile(title: 'Jobsite', icon: Icons.account_balance_outlined),
            DrawerListTile(title: 'Team', icon: Icons.person),
            DrawerListTile(title: 'Time Off', icon: Icons.flight),
            DrawerListTile(title: 'Schedules', icon: Icons.calendar_today),
            Divider(),
            DrawerListTile(
              title: 'Request to join organisation',
              icon: Icons.account_tree_outlined,
            ),
            DrawerListTile(title: 'Change Password', icon: Icons.password),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title;
  final IconData icon;

  const DrawerListTile({
    required this.title,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: false,
      selectedTileColor: Colors.teal[100],
      onTap: () => Navigator.pop(context),
    );
  }
}