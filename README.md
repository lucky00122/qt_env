# Qt Environment Installation File
The repository for Qt environment installation file. 

## Building Qt 5 for Android(Linux)
1. The following packages (alternatives may be supported) for Debian-based Linux are required:
```
sudo apt-get update
sudo apt-get upgrade
apt install build-essential default-jre openjdk-8-jdk-headless android-sdk android-sdk-platform-23 libc6-i386
```
2. Download script: [install_android_sdk_ndk.sh](https://github.com/lucky00122/qt_env/blob/main/install_android_sdk_ndk.sh)
3. Run the script
```
source install_android_sdk_ndk.sh
```
