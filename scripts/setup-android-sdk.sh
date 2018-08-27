#!/bin/sh
set -e -u

# Install desired parts of the Android SDK:
. $(cd "$(dirname "$0")"; pwd)/properties.sh
test -f $HOME/.termuxrc && . $HOME/.termuxrc
: ${ANDROID_HOME:="${HOME}/lib/android-sdk"}
: ${NDK:="${HOME}/lib/android-ndk"}
ANDROID_SDK_FILE=sdk-tools-linux-4333796.zip
ANDROID_SDK_SHA256=92ffee5a1d98d856634e8b71132e8a95d96c83a63fde1099be3d86df3106def9
ANDROID_NDK_FILE=android-ndk-r${TERMUX_NDK_VERSION}-$(uname)-x86_64.zip
ANDROID_NDK_SHA256=ba3d813b47de75bc32a2f3de087f72599c6cb36fdc9686b96f517f5492ff43ca

if [ ! -d $ANDROID_HOME ]; then
	mkdir -p $ANDROID_HOME
	cd $ANDROID_HOME/..
	rm -Rf `basename $ANDROID_HOME`

	# https://developer.android.com/studio/index.html#command-tools
	# The downloaded version below is 26.1.1.:
	curl --fail --retry 3 \
		-o tools.zip \
		https://dl.google.com/android/repository/${ANDROID_SDK_FILE}
	echo "${ANDROID_SDK_SHA256} tools.zip" | sha256sum -c -
	rm -Rf android-sdk
	unzip -q tools.zip -d android-sdk
	rm tools.zip
fi

if [ ! -d $NDK ]; then
	mkdir -p $NDK
	cd $NDK/..
	rm -Rf `basename $NDK`
	curl --fail --retry 3 -o ndk.zip \
		http://dl.google.com/android/repository/${ANDROID_NDK_FILE}
	echo "${ANDROID_NDK_SHA256} ndk.zip" | sha256sum -c -
	rm -Rf android-ndk-r$TERMUX_NDK_VERSION
	unzip -q ndk.zip
	mv android-ndk-r$TERMUX_NDK_VERSION `basename $NDK`
	rm ndk.zip
fi

yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses

# The android-21 platform is used in the ecj package:
$ANDROID_HOME/tools/bin/sdkmanager "build-tools;${TERMUX_ANDROID_BUILD_TOOLS_VERSION}" "platforms;android-27" "platforms;android-21"
