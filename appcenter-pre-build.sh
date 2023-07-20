#!/usr/bin/env bash

# Pre Build Script

set -e # Exit immediately if a command exits with a non-zero status (failure)


echo 
echo "**************************************************************************************************"
echo "MY CUSTOM Pre-BUILD SCRIPT STARTS ..."
echo "**************************************************************************************************"



echo "list files in APPCENTER_SOURCE_DIRECTORY"
ls $APPCENTER_SOURCE_DIRECTORY

# Run Android APPDebug & APPTest
cd $APPCENTER_SOURCE_DIRECTORY/android
# ./gradlew assembleDebug
./gradlew assembleRelease
./gradlew assembleAndroidTest

# variables
appCenterLoginApiToken=$APPCENTER_ACCESS_TOKEN
locale="en_US"
appName="CI-CD-POC/cicdDemoApp-1"
deviceSetName="CI-CD-POC/android-devices"
testSeriesName="test-series"
appDebugPath=$APPCENTER_SOURCE_DIRECTORY/android/app/build/outputs/apk/debug/app-debug.apk
appReleasePath=$APPCENTER_SOURCE_DIRECTORY/android/app/build/outputs/apk/release/app-release.apk
buildDir=$APPCENTER_SOURCE_DIRECTORY/android/app/build/outputs/apk/androidTest/debug

# Run UITest if branch is master
if [ "$APPCENTER_BRANCH" == "dev" ];
then
    # app center command espresso test
    echo "########## $appName espresso start ##########"
    appcenter test run espresso --app $appName --devices $deviceSetName --app-path $appReleasePath --test-series $testSeriesName --locale $locale --build-dir $buildDir --token $appCenterLoginApiToken;
    echo "########## $appName espresso finished ##########"
else
    echo "Current branch is not 'dev'"
fi

cd ..

echo 
echo "**************************************************************************************************"
echo "MY CUSTOM Pre-BUILD SCRIPT ENDS ..."
echo "**************************************************************************************************"
