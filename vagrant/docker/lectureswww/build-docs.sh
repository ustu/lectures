#! /bin/bash
#
# build-docs.sh
# Copyright (C) 2016 uralbash <root@uralbash.ru>
#
# Distributed under terms of the MIT license.
#


env
cd /home/vagrant/lectureswww &&
    make clean html
