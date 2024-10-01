import 'dart:io';
import 'package:path/path.dart' as p;

void main() {
  final directory = Directory.current;
  convertImports(directory);
}

void convertImports(Directory directory) {
  final entities = directory.listSync(recursive: true);

  for (final entity in entities) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final lines = entity.readAsLinesSync();
      final newLines = lines.map((line) {
        final packageImportPattern = RegExp(r"import 'package:([^/]+)/(.+)';");
        final match = packageImportPattern.firstMatch(line);

        if (match != null) {
          final packageName = match.group(1);
          final importPath = match.group(2);
          final relativePath = p.relative(importPath!, from: p.dirname(entity.path));
          return "import '$relativePath';";
        }
        return line;
      }).toList();
      entity.writeAsStringSync(newLines.join('\n'));
    }
  }
  print('Imports converted to relative paths.');
}
