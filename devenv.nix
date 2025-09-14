{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  
  # Java/Kotlin development
  languages.java = {
    enable = true;
    jdk.package = pkgs.jdk21;
  };

  # https://devenv.sh/packages/
  packages = with pkgs; [
    git
    gradle
  ];

  # Environment variables for Android development
  # These will need to be updated once Android SDK is installed
  env.ANDROID_HOME = "$HOME/Library/Android/sdk";
  env.ANDROID_SDK_ROOT = "$HOME/Library/Android/sdk";
  # JAVA_HOME is automatically set by languages.java.enable

  enterShell = ''
    echo "Basketball Tracker Dev Environment"
    echo "Java: $(java -version 2>&1 | head -n 1)"
    echo "Run Android Studio to set up Android SDK"
  '';
}