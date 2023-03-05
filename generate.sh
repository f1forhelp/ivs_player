flutter pub run pigeon \
  --input pigeons/message.dart \
  --dart_out lib/pigeon.dart \
  --objc_header_out ios/Runner/pigeon.h \
  --objc_source_out ios/Runner/pigeon.m \
  --experimental_swift_out ios/Runner/Pigeon.swift \
  --experimental_kotlin_out ./android/app/src/main/kotlin/dev/flutter/pigeon/Pigeon.kt \
  --experimental_kotlin_package "dev.flutter.pigeon" \
  --java_out ./android/app/src/main/java/dev/flutter/pigeon/Pigeon.java \
  --java_package "dev.flutter.pigeon"