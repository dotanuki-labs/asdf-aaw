# asdf-aaw

[![CI](https://github.com/dotanuki-labs/asdf-aaw/actions/workflows/ci.yml/badge.svg)](https://github.com/dotanuki-labs/asdf-aaw/actions/workflows/ci.yml)
[![Code Style](https://img.shields.io/badge/code%20style-%E2%9D%A4-FF4081.svg)](https://shellcheck.net/)
[![License](https://img.shields.io/github/license/dotanuki-labs/asdf-aaw)](https://choosealicense.com/licenses/mit)


A [android-archives-watchdog](https://github.com/dotanuki-las/android-archives-watchdog)
plugin for [asdf](https://github.com/asdf-vm/asdf).


## Installing

Installing this plugin:

```bash
$> asdf plugin add aaw https://github.com/dotanuki-labs/asdf-aaw.git
```

## Using

Managing `aaw` with `asdf`:

```bash

# Shows all installable versions
$> asdf list-all aaw

# Downloads the latest version
$> asdf install aaw latest

# Defines the latest version for your local project (writes <project>/.tool-versions)
$> asdf local aaw latest

# Now aaw commands are available
$> aaw version

# Rolls-back / installs a specific version
$> asdf install aaw 0.1.0

```

You may also want to check the [official documentation](https://asdf-vm.com/) to learn more about `asdf`.

## License

Copyright (c) 2023 - Dotanuki Labs - [The MIT license](https://choosealicense.com/licenses/mit/)

