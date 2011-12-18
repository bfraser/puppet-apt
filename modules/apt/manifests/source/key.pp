define apt::source::key ($ensure) {
  include apt

  file { "/root/apt/keys/${name}.asc":
    ensure	=> file,
    source	=> "puppet:///modules/apt/keys/${name}.asc",
    owner	=> root,
    group	=> root,
    mode	=> 644,
    before	=> Exec["apt-key present $name"],
  }

  case $ensure {
    present: {
      exec { "apt-key present $name":
        command	=> "/usr/bin/apt-key add /root/apt/keys/${name}.asc",
        unless	=> "/usr/bin/apt-key list | /bin/grep -c $name",
      }
    }
    absent: {
      exec { "apt-key absent $name":
        command => "/usr/bin/apt-key del $name",
        onlyif	=> "/usr/bin/apt-key list | /bin/grep -c $name",
      }
    }
    default: {
      fail "Invalid 'ensure' value '$ensure' for apt::source::key."
    }
  }
}
