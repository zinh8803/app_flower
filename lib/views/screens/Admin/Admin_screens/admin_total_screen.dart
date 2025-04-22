import 'package:flutter/material.dart';
import 'package:frontend_appflowershop/utils/preference_service.dart';
import 'package:frontend_appflowershop/views/screens/Admin/Admin_screens/AdminOrderScreen.dart';
import 'package:frontend_appflowershop/views/screens/Admin/Admin_screens/admin_Category_srceen.dart';
import 'package:frontend_appflowershop/views/screens/Admin/Admin_screens/admin_product_screen.dart';
import 'package:frontend_appflowershop/views/screens/Admin/Admin_screens/admin_statistic_screen.dart';

class AdminStaffScreen extends StatelessWidget {
  const AdminStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Quản lý nhân viên (Chưa triển khai)',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

// class AdminStatisticScreen extends StatelessWidget {
//   const AdminStatisticScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Thống kê doanh thu (Chưa triển khai)',
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }
// }

class AdminTotalScreen extends StatefulWidget {
  const AdminTotalScreen({super.key});

  @override
  State<AdminTotalScreen> createState() => _AdminTotalScreenState();
}

class _AdminTotalScreenState extends State<AdminTotalScreen> {
  int _selectedIndex = 0;

  // Danh sách các màn hình cho từng tab
  final List<Widget> _screens = [
    const AdminProductScreen(), // Tab quản lý sản phẩm
    const CategoryListScreen(), // Tab quản lý danh mục
    const AdminOrderScreen(), // Tab quản lý đơn hàng
    // const AdminStaffScreen(), // Tab quản lý nhân viên
    const AdminStatisticScreen(), // Tab thống kê doanh thu
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Tổng'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Xóa thông tin đăng nhập
              await PreferenceService.clearToken();
              // Chuyển hướng về trang login
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: 'Sản phẩm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Danh mục',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Đơn hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Thống kê',
          ),
        ],
      ),
    );
  }
}
