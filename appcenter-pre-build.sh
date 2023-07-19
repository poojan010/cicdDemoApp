#!/usr/bin/env bash

echo "MY CUSTOM PRE-BUILD SCRIPT..."

echo "Now updating the snapshots..."
npm test -u
echo "Done updating the snapshots"

