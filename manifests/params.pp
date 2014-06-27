# Copyright 2014 Martin Schulze
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
# Class: locale::params
#
# Params for locale OS specific parts.
#
# Parameters:

# Actions:
#
# Requires:
#
# Sample Usage:
#
class locale::params (
) {
  case $::operatingsystem {
    'centos', 'redhat', 'fedora': {
      # Remove this comment and the followning line if you add OS support.
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
      $locale_conf_file       = '/etc/locale.conf'
      $locale_gen_file        = '/etc/locale.gen'
      $z20_keyboard_conf_file = '/etc/X11/xorg.conf.d/20-keyboard.conf'
      $vconsole_conf_file     = '/etc/vconsole.conf'
    }
    'ubuntu', 'debian': {
      # Remove this comment and the followning line if you add OS support.
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
      $locale_conf_file       = '/etc/locale.conf'
      $locale_gen_file        = '/etc/locale.gen'
      $z20_keyboard_conf_file = '/etc/X11/xorg.conf.d/20-keyboard.conf'
      $vconsole_conf_file     = '/etc/vconsole.conf'
    }
    'Archlinux': {
      $locale_conf_file       = '/etc/locale.conf'
      $locale_gen_file        = '/etc/locale.gen'
      $z20_keyboard_conf_file = '/etc/X11/xorg.conf.d/20-keyboard.conf'
      $vconsole_conf_file     = '/etc/vconsole.conf'
    }
    default: {
      # Don't do changes here. This will fail on all OS that aren't explicitly supported.
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}
