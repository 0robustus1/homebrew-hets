# homebrew-hets

This is an attempt to create usuable homebrew formulas for hets (the [heterogeneous toolset][1])
for the developers of [ontohub][2] who use Mac OS X as their development platform.

I hope this helps...

## Instructions

In order to use this tap you'll need to perform some basic command-line tasks:

- `brew tap 0robustus1/hets` to make this tap available to your homebrew installation
- `brew install hets --with-nightly` to install the most recent version of hets

### Some notes

Installing hets will fetch the most recent version of hets known to this
formula, but adding the `--with-nightly` switch will also fetch the
most recent nightly build (always) and update your hets-binary with it.
