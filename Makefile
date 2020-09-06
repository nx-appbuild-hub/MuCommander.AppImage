# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
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

all: clean
	rm -rf $(PWD)/build
	mkdir -p $(PWD)/build

	wget --output-document=$(PWD)/build/build.tar.gz  https://github.com/mucommander/mucommander/releases/download/0.9.5-1/mucommander-0.9.5-1.tar.gz
	cd $(PWD)/build && tar -zxvf $(PWD)/build/build.tar.gz && cd ..

	mkdir -p $(PWD)/AppDir/application
	cp -r $(PWD)/build/* $(PWD)/AppDir/application
	rm -rf $(PWD)/AppDir/application/felix-cache
	ln -s /tmp/mucommander/felix-cache $(PWD)/AppDir/application/felix-cache
	rm -rf $(PWD)/AppDir/application/*.rpm
	rm -rf $(PWD)/AppDir/application/*.zip
	rm -rf $(PWD)/AppDir/application/*.tar
	rm -rf $(PWD)/AppDir/application/*.gz
	rm -rf $(PWD)/build/*

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm --continue https://forensics.cert.org/centos/cert/8/x86_64/jdk-12.0.2_linux-x64_bin.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	mkdir -p $(PWD)/AppDir/java
	cp -r $(PWD)/build/usr/java $(PWD)/AppDir
	rm -rf $(PWD)/build/*


	export ARCH=x86_64 && $(PWD)/bin/appimagetool-x86_64.AppImage  $(PWD)/AppDir $(PWD)/MuCommander.AppImage
	@echo "done: MuCommander.AppImage"
	make clean


clean:
	rm -rf ${PWD}/AppDir/application
	rm -rf ${PWD}/AppDir/java
	rm -rf ${PWD}/build
