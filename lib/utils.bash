#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/dotanuki-labs/android-archives-watchdog"
TOOL_NAME="aaw"
TOOL_TEST="aaw version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' | grep -v 'cli'
}

list_all_versions() {
  list_github_tags
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  # Eg : https://github.com/dotanuki-labs/android-archives-watchdog/releases/download/0.1.0/aaw-0.1.0.zip
  url="$GH_REPO/releases/download/$version/aaw-$version.zip"

  echo "* Downloading $TOOL_NAME release $version..."
  echo
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"

}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path/bin"
    cp "$ASDF_DOWNLOAD_PATH/aaw" "$install_path/bin"

    local tool_cmd="/bin/aaw"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"

  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}
