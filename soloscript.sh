#!/bin/bash
# This shell script was created at solowizard.com
#
# Usage:
#   Running the script remotely:
#     bash < <(curl -s http://www.solowizard.com/soloist_scripts/fh10ww.sh )
#   Running the script if you have downloaded it:
#     ./fh10ww.sh
#
# http://github.com/tommyh/solo_wizard
# (c) 2012, Tom Hallett
# This script may be freely distributed under the MIT license.

pushd `pwd`
if rvm --version 2>/dev/null; then
  gem install soloist
else
  sudo gem install soloist
fi

mkdir -p ~/cookbooks; cd ~/cookbooks
cat > soloistrc <<EOF
cookbook_paths:
- $PWD
recipes:
- pivotal_workstation::ack
- pivotal_workstation::alfred
- pivotal_workstation::defaults_fast_key_repeat_rate
- pivotal_workstation::enable_assistive_devices
- pivotal_workstation::function_keys
- pivotal_workstation::imagemagick
- pivotal_workstation::keyboard_preferences
- pivotal_workstation::menubar_preferences
- pivotal_workstation::mongodb
- pivotal_workstation::node_js
- pivotal_workstation::postgres
- pivotal_workstation::qt
- pivotal_workstation::redis
- pivotal_workstation::rvm
- pivotal_workstation::sublime_text
- pivotal_workstation::unix_essentials
EOF
if [[ -d pivotal_workstation ]]; then
  cd pivotal_workstation && git pull && cd ..
else
  git clone https://github.com/pivotal/pivotal_workstation.git
fi
if [[ -d dmg ]]; then
  cd dmg && git pull && cd ..
else
  git clone https://github.com/opscode-cookbooks/dmg.git
fi
soloist
popd