#!/bin/bash

set -ex

year=2022
version=3390400

pushd "$(realpath $(dirname $0))"
    curl -o sqlite-amalgamation.zip https://sqlite.org/$year/sqlite-amalgamation-$version.zip
    unzip sqlite-amalgamation.zip -d ./
    rm -rf sqlite-amalgamation.zip

    cp sqlite-amalgamation-$version/sqlite3.c Sources/SQLite
    cp sqlite-amalgamation-$version/sqlite3.h Sources/SQLite/include
    cp sqlite-amalgamation-$version/sqlite3ext.h Sources/SQLite/include
    
    rm -rf sqlite-amalgamation-$version
popd
