TERMUX_PKG_HOMEPAGE=http://openal-soft.org/
TERMUX_PKG_DESCRIPTION="Software implementation of the OpenAL API"
TERMUX_PKG_VERSION=1.18.2
TERMUX_PKG_SHA256=9f8ac1e27fba15a59758a13f0c7f6540a0605b6c3a691def9d420570506d7e82
TERMUX_PKG_SRCURL=http://openal-soft.org/openal-releases/openal-soft-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DALSOFT_UTILS=OFF
-DALSOFT_EXAMPLES=OFF
-DALSOFT_TESTS=OFF
"
