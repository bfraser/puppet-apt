define apt::source ($keys, $ensure) {
  include apt

  file { "/etc/apt/sources.list.d/${name}.list":
    ensure	=> file,
    source	=> "puppet:///modules/apt/sources/${name}.list",
    owner	=> root,
    group	=> root,
    mode	=> 644,
  }

  apt::source::key { $keys:
    ensure	=> $ensure,
    before	=> File["/etc/apt/sources.list.d/${name}.list"],
  }

  exec { "${name} apt update":
    command     => "${apt::get} update",
    subscribe   => File["/etc/apt/sources.list.d/${name}.list"],
    refreshonly => true,
  }
}
