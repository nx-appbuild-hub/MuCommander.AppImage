# Copyright 2022 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)

.PHONY: all

all: clean init
	mkdir --parents $(PWD)/build/mucommander
	mkdir --parents $(PWD)/build/Boilerplate.AppDir/mucommander
	$(PWD)/bin/Apprepo.AppImage --destination=$(PWD)/build appdir boilerplate openjdk-8-jre-headless libglib2.0-0 libselinux1

	echo '' 										>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 										>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'mkdir -p /tmp/mucommander/felix-cache' 	>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 										>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 										>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '$${APPDIR}/lib64/jvm/java-8-openjdk-amd64/bin/java -DGNOME_DESKTOP_SESSION_ID=$${GNOME_DESKTOP_SESSION_ID} -DKDE_FULL_SESSION=$${KDE_FULL_SESSION} -DKDE_SESSION_VERSION=$${KDE_SESSION_VERSION} -Djava.library.path=$${APPDIR}/lib64 -cp $${APPDIR}/mucommander/mucommander.jar com.mucommander.main.muCommander $${@}' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 										>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 										>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'rm -rf /tmp/mucommander' 					>> $(PWD)/build/Boilerplate.AppDir/AppRun

	cp --force $(PWD)/AppDir/*.desktop     $(PWD)/build/Boilerplate.AppDir || true
	cp --force $(PWD)/AppDir/*.svg         $(PWD)/build/Boilerplate.AppDir || true
	cp --force $(PWD)/AppDir/*.png         $(PWD)/build/Boilerplate.AppDir || true

	wget --output-document=$(PWD)/build/build.tar.gz  https://github.com/mucommander/mucommander/releases/download/0.9.6-1/mucommander-0.9.6-1.tar.gz
	cd $(PWD)/build && tar -zxvf $(PWD)/build/build.tar.gz --directory=$(PWD)/build/mucommander

	rm -rf $(PWD)/build/mucommander/felix-cache

	cp --force --recursive $(PWD)/build/mucommander/* $(PWD)/build/Boilerplate.AppDir/mucommander
	cp --force $(PWD)/build/Boilerplate.AppDir/mucommander/mucommander*.jar $(PWD)/build/Boilerplate.AppDir/mucommander/mucommander.jar

	ln -s /tmp/mucommander/felix-cache $(PWD)/build/Boilerplate.AppDir/mucommander/felix-cache
	rm -rf $(PWD)/build/Boilerplate.AppDir/mucommander/*.rpm
	rm -rf $(PWD)/build/Boilerplate.AppDir/mucommander/*.zip
	rm -rf $(PWD)/build/Boilerplate.AppDir/mucommander/*.tar
	rm -rf $(PWD)/build/Boilerplate.AppDir/mucommander/*.gz

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/MuCommander.AppImage
	chmod +x $(PWD)/MuCommander.AppImage


init:
	mkdir --parents $(PWD)/bin

	wget https://apprepo.de/appimage/download/apprepo \
		--output-document=$(PWD)/bin/Apprepo.AppImage
	chmod +x $(PWD)/bin/Apprepo.AppImage

	wget https://github.com/AppImage/AppImageKit/releases/download/13/appimagetool-x86_64.AppImage \
		--output-document=$(PWD)/bin/appimagetool.AppImage
	chmod +x $(PWD)/bin/appimagetool.AppImage

clean:
	rm -rf $(PWD)/*.AppImage
	rm -rf $(PWD)/bin/*
	rm -rf $(PWD)/build
