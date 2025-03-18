# Use the official Flutter base image
FROM ghcr.io/cirruslabs/flutter:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the entire Flutter project into the container
COPY . .

# Enable Flutter web support (optional)
RUN flutter config --enable-web

# Get dependencies
RUN flutter pub get

# Build the Flutter application for APK
RUN flutter build apk

# Expose the port for web apps (optional)
EXPOSE 8080

