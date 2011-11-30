define apt::source ($keys, $ensure) {
  include apt

  file { "/etc/apt/sources.list.d/${name}.list":
    ensure => file,
    source => "puppet:///modules/apt/sources/${name}.list",
    owner => root,
    group => root,
    mode => 644,
    notify => Exec[ Apt['/usr/bin/apt-get update'] ],
  }

  apt::source::key { $keys:
    ensure => $ensure,
  }
}
