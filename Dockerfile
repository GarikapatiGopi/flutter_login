# Use Flutter base image
FROM cirrusci/flutter:latest

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Enable Flutter web
RUN flutter config --enable-web

# Install dependencies
RUN flutter pub get

# Build the APK
RUN flutter build apk

# Set default command
CMD ["flutter", "run"]
