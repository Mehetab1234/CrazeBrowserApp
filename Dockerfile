FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

# Install Java 11, Gradle, Android SDK, and other required dependencies
RUN apt-get update && apt-get install -y \
  openjdk-11-jdk \
  gradle \
  unzip \
  wget \
  curl \
  build-essential \
  && rm -rf /var/lib/apt/lists/*

# Install Android SDK
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip -O android-sdk.zip \
  && unzip android-sdk.zip -d /opt/android-sdk \
  && rm android-sdk.zip

# Set up Android SDK environment variables
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH

# Accept Android SDK licenses
RUN yes | sdkmanager --licenses

# Install required Android packages
RUN sdkmanager "platforms;android-30" "build-tools;30.0.3" "platform-tools"
