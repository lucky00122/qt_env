#!/bin/bash

ndkVersion="r19c"
sdkBuildToolsVersion="28.0.3"
sdkApiLevel="android-28"
toolsVersion="r26.1.1"

repository=https://dl.google.com/android/repository
toolsFile=sdk-tools-linux-4333796.zip
toolsFolder=android-sdk-tools
ndkFile=android-ndk-$ndkVersion-linux-x86_64.zip
ndkFolder=android-ndk-$ndkVersion

rm -rf $toolsFolder
rm -rf $ndkFolder

echo "Downloading SDK tools from $repository"
wget -q $repository/$toolsFile
unzip -qq $toolsFile -d $toolsFolder

echo "Downloading NDK from $repository"
wget -q $repository/$ndkFile
unzip -qq $ndkFile

rm $toolsFile
rm $ndkFile

echo "Configuring environment"
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin

# Optional workaround for issue with certain JDK/JRE versions
#cp $toolsFolder/tools/bin/sdkmanager $toolsFolder/tools/bin/sdkmanager.backup
#sed -i 's/^DEFAULT_JVM_OPTS.*/DEFAULT_JVM_OPTS='"'\"-Dcom.android.sdklib.toolsdir=\$APP_HOME\" -XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'"'/' \
#        $toolsFolder/tools/bin/sdkmanager

echo "Installing SDK packages"
cd $toolsFolder/tools/bin
echo "y" | ./sdkmanager "platforms;$sdkApiLevel" "platform-tools" "build-tools;$sdkBuildToolsVersion" >> sdkmanager.log
echo "y" | ./sdkmanager --install "emulator" >> sdkmanager.log
echo "y" | ./sdkmanager --install "system-images;android-21;google_apis;x86" >> sdkmanager.log
echo "no" | ./avdmanager create avd -n x86emulator -k "system-images;android-21;google_apis;x86" -c 2048M -f >> sdkmanager.log

echo "Provisioning complete. Here's the list of packages and avd devices:"
./sdkmanager --list
./avdmanager list avd