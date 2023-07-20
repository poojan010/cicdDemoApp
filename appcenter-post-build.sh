#!/usr/bin/env bash

# Post Build Script

set -e # Exit immediately if a command exits with a non-zero status (failure)


echo 
echo "**************************************************************************************************"
echo "MY CUSTOM Post-BUILD SCRIPT STARTS ..."
echo "**************************************************************************************************"


# Run UITest if branch is master
if [ "$RUN_UI_TESTS" == true ];
then
    if [ -z "$APP_CENTER_CURRENT_PLATFORM" ]
    then
        echo "You need to define the APP_CENTER_CURRENT_PLATFORM variable in App Center with values android or ios"
        exit
    else 
        echo "APP_CENTER_CURRENT_PLATFORM defined"
    fi
    if [ "$APP_CENTER_CURRENT_PLATFORM" == "android" ]
    then
        #android

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

        # app center command espresso test
        echo "########## $appName espresso start ##########"
        appcenter test run espresso --app $appName --devices $deviceSetName --app-path $appReleasePath --test-series $testSeriesName --locale $locale --build-dir $buildDir --token $appCenterLoginApiToken;
        echo "########## $appName espresso finished ##########"

        cd ..
    else
        #iOS
        echo "ios platform"
    fi
else
    echo "Do not run UI tests"
fi


echo 
echo "**************************************************************************************************"
echo "MY CUSTOM Post-BUILD SCRIPT ENDS ..."
echo "**************************************************************************************************"
