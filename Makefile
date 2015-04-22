BUILDROOT=build
TEMPROOT=temp

all: AsyncNetworkOSX AsyncNetworkIOS

clean:
	rm -rf $(BUILDROOT)
	rm -rf AsyncNetwork.framework
	rm -rf AsyncNetworkIOS.framework

# build
AsyncNetworkOSX:
	mkdir -p $(TEMPROOT)
	xcodebuild build -target AsyncNetwork | egrep "^(===|\*\*)"
	cp -r $(BUILDROOT)/Release/AsyncNetwork.framework $(TEMPROOT)

AsyncNetworkIOS:
	xcodebuild build -target AsyncNetworkIOS -sdk iphoneos | egrep "^(===|\*\*)"
	xcodebuild build -target AsyncNetworkIOS -sdk iphonesimulator | egrep "^(===|\*\*)"
	mkdir -p $(TEMPROOT)
	cp -r $(BUILDROOT)/Release-iphoneos/AsyncNetworkIOS.framework $(TEMPROOT)
	rm $(TEMPROOT)/AsyncNetworkIOS.framework/AsyncNetworkIOS
	lipo -o $(TEMPROOT)/AsyncNetworkIOS.framework/AsyncNetworkIOS -create\
		$(BUILDROOT)/Release-iphoneos/AsyncNetworkIOS.framework/AsyncNetworkIOS\
		$(BUILDROOT)/Release-iphonesimulator/AsyncNetworkIOS.framework/AsyncNetworkIOS

# make distribution copy

dist:
	mkdir -p $(TEMPROOT)
	cp -rf Examples Icon.png License.txt README.md $BUILDROOT/Release/* $BUILDROOT/Release-iphoneos/*\
 $TEMPROOT
	lipo -o $TEMPROOT/AsyncNetworkIOS.framework/AsyncNetworkIOS -create\
		$BUILDROOT/Release-iphoneos/AsyncNetworkIOS.framework/AsyncNetworkIOS\
		$BUILDROOT/Release-iphonesimulator/AsyncNetworkIOS.framework/AsyncNetworkIOS
	rm -rf $TEMPROOT/Examples/*/*.xcodeproj/project.xcworkspace
	rm -rf $TEMPROOT/Examples/*/*.xcodeproj/xcuserdata

# create disk image
AsyncNetwork.dmg: dist
	rm -f AsyncNetwork.dmg
	hdiutil create -srcfolder $TEMPROOT -fs HFS+ -volname AsyncNetwork AsyncNetwork.dmg
	cp -rf $TEMPROOT/AsyncNetwork* .
	rm -rf $TEMPROOT