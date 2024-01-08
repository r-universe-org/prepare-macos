#!/bin/bash
TEMP_CARGO_CONFIG="${CARGO_HOME:-$HOME/.cargo}"
mkdir -p "$TEMP_CARGO_CONFIG"
echo '[build]' >> "${TEMP_CARGO_CONFIG}/config.toml"
echo 'target = "aarch64-apple-darwin"' >> "${TEMP_CARGO_CONFIG}/config.toml"
"$HOME/.cargo/bin/cargo" "$@"

# I could not get build.target-dir to do the right thing
if [ "$1" = "build" ];then
targetdir=$(find . -path '*target/aarch64-apple-darwin')
if [ "$targetdir" ]; then
  echo "targetdir: $targetdir"
  #(cd $(dirname $targetdir); ln -sfv aarch64-apple-darwin/* .) || true
  cp -Rf $targetdir/* $(dirname $targetdir)
fi
fi
