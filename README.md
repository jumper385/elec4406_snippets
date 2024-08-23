# Installing GHDL
## MacOS ARM Installation

for some reason it doesnt work with `brew install ghdl` out of the box. follow this instead.

    read https://www.reddit.com/r/VHDL/comments/12707lp/ghdl_on_mac_m1/...

run `brew install ghdl`

Because there is, as of now, an issue with Apple's LLVM and ghdl, we will use the mcode version (I did not have this issue a 2 months ago...). However, brew installs the LLVM version of ghdl. We will therefore download the mcode version of ghdl from the official github repo and then replace the brew-installed LLVM version with the manually downloaded mcode version.

- Download the mcode version of ghdl: https://github.com/ghdl/ghdl/releases/download/v3.0.0/ghdl-macos-11-mcode.tgz
- Unzip the downloaded ghdl-macos-11-mcode.tgz
- Go to /opt/homebrew/Caskroom/ghdl/3.0.0 and delete the bin, include and lib directories (these contain the llvm version that is causing problems)
- Copy the bin, include and lib directories from the unzipped ghdl-macos-11-mcode directory to the /opt/homebrew/Caskroom/ghdl/3.0.0 directory
- We are done! You might have to go to the Privacy and Security settings of your mac to allow the execution of ghdl when you run it for the first time
