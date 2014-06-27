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
# Class: locale
#
# Sets linux locale for both term and X.
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class locale(
  $locale,
  $keymap,
  $keymap_x,
  $keymap_x_variant,
  $use_eu_norm     = false,
  $local_clock_rtc = true,
) {

  include locale::params

  $locale_conf_LANG = $locale
  $locale_conf_DATE_NUMERIC_TIME = $use_eu_norm ? {
    true  => 'en_DK.utf8',
    false => $locale,
    default => 'en_DK.utf8',
  }
  $locale_conf_DATE = $locale_conf_DATE_NUMERIC_TIME
  $locale_conf_NUMERIC = $locale_conf_DATE_NUMERIC_TIME
  $locale_conf_TIME = $locale_conf_DATE_NUMERIC_TIME

  $vconsole_conf_KEYMAP = $keymap
  $keyboard_conf_KEYMAP_X = $keymap_x
  $keyboard_conf_KEYMAP_X_VARIANT = $keymap_x_variant

  $locale_gen_LOCALE = $locale
  $locale_gen_LOCALE_EU = $use_eu_norm ? {
    true  => 'en_DK.utf8',
    false => $locale,
    default => 'en_DK.utf8',
  }

  if ! ($use_eu_norm in [ true, false ]) {
    fail("locale use_eu_norm parameter must be true false")
  }

  if ! ($local_clock_rtc in [ true, false ]) {
    fail("locale local_clock_rtc parameter must be true false")
  }

  file { 'locale.conf' :
    path   => "${locale::params::locale_conf_file}",
    ensure => present,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    content=>template("locale/locale.conf.erb"),
  }

  file { 'locale.gen' :
    path   => "${locale::params::locale_gen_file}",
    ensure => present,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    content=>template("locale/locale.gen.erb"),
  }

  file { '20-keyboard.conf' :
    path   => "${locale::params::z20_keyboard_conf_file}",
    ensure => present,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    content=>template("locale/Z20-keyboard.conf.erb"),
  }

  file { 'vconsole.conf' :
    path   => "${locale::params::vconsole_conf_file}",
    ensure => present,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    content=>template("locale/vconsole.conf.erb"),
  }

  exec { 'locale-gen' :
    command => '/usr/bin/locale-gen',
    require => [ File [ 'locale.conf' ],
                 File [ 'locale.gen' ],
                 File [ '20-keyboard.conf' ],
                 File [ 'vconsole.conf' ],
               ],
  }

}
