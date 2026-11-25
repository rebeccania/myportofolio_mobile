import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';
  bool _isSubmitting = false;

  bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  Widget _buildField({
    required String label,
    required String hint,
    required ValueChanged<String> onChanged,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final authState = context.read<AuthState>();
    final apiClient = context.read<ApiClient>();
    final messenger = ScaffoldMessenger.of(context);

    final loggedIn = await ensureLoggedIn(context);
    if (!loggedIn || !mounted) return;

    setState(() {
      _isSubmitting = true;
    });

    final newProject = Project(
      title: _title.trim(),
      description: _description.trim(),
      techStack: _techStack.trim(),
      projectUrl: _projectUrl.trim(),
      projectImageUrl: _projectImageUrl.trim(),
    );

    try {
      final created = await apiClient.createProject(
        newProject,
        token: authState.token!,
      );
      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Proyek berhasil ditambahkan!'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${created.title}'),
                  Text('Description: ${created.description}'),
                  Text('Tech Stack: ${created.techStack}'),
                  Text('Project URL: ${created.projectUrl}'),
                  Text(
                    'Image URL: ${created.projectImageUrl.isEmpty ? "-" : created.projectImageUrl}',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      if (!mounted) return;
      _formKey.currentState!.reset();
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        await authState.logout();
        messenger.showSnackBar(
          const SnackBar(content: Text('Session expired. Please login again.')),
        );
        if (!mounted) return;
        await ensureLoggedIn(context);
      } else if (e.statusCode == 403) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Only a superuser can create projects.'),
          ),
        );
      } else {
        messenger.showSnackBar(
          SnackBar(
            content: Text('Failed to create project (${e.statusCode}).'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Project Form',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildField(
                label: 'Title',
                hint: 'Project title',
                onChanged: (value) => _title = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title cannot be empty!';
                  }
                  return null;
                },
              ),
              _buildField(
                label: 'Description',
                hint: 'Project description',
                maxLines: 5,
                onChanged: (value) => _description = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description cannot be empty!';
                  }
                  return null;
                },
              ),
              _buildField(
                label: 'Tech Stack',
                hint: 'Example: Flutter, Django, Figma',
                onChanged: (value) => _techStack = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tech stack cannot be empty!';
                  }
                  return null;
                },
              ),
              _buildField(
                label: 'Project URL',
                hint: 'https://example.com',
                onChanged: (value) => _projectUrl = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Project URL cannot be empty!';
                  }
                  if (!_isValidUrl(value.trim())) {
                    return 'Invalid URL (must start with http:// or https://)';
                  }
                  return null;
                },
              ),
              _buildField(
                label: 'Project Image URL (Optional)',
                hint: 'https://example.com/image.png',
                onChanged: (value) => _projectImageUrl = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return null;
                  if (!_isValidUrl(value.trim())) {
                    return 'Invalid URL (must start with http:// or https://)';
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Save'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
