import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// Profile Settings
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Account & Profile'),
            subtitle: const Text('Edit name, email, password'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to profile settings
            },
          ),

          /// Notifications
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Enable or disable notifications'),
            value: _notificationsEnabled,
            onChanged: (val) {
              setState(() => _notificationsEnabled = val);
            },
          ),

          /// Theme toggle
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            subtitle: const Text('Toggle between light and dark theme'),
            value: _isDarkMode,
            onChanged: (val) {
              setState(() => _isDarkMode = val);
              // Add theme change logic here if needed
            },
          ),

          /// Language
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: Text(_selectedLanguage),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showLanguageDialog();
            },
          ),

          /// Privacy & Security
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Privacy & Security'),
            subtitle: const Text('Manage app permissions & data'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Open privacy settings
            },
          ),

          /// Help & Feedback
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & Feedback'),
            subtitle: const Text('FAQs, Contact Support'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Open help or feedback form
            },
          ),

          const Divider(),

          /// Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              // Handle logout logic here
              _showLogoutDialog();
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['English', 'Hindi', 'Spanish', 'French'].map((lang) {
              return RadioListTile(
                value: lang,
                groupValue: _selectedLanguage,
                title: Text(lang),
                onChanged: (value) {
                  setState(() => _selectedLanguage = value.toString());
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Perform logout action here
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
