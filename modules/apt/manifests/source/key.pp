define apt::source::key ($ensure) {
  include apt

  file { "/root/apt/keys/${keyid}.asc":
    ensure	=> file,
    source	=> "puppet:///modules/apt/keys/${keyid}.asc",
    owner	=> root,
    group	=> root,
    mode	=> 644,
    before	=> Exec["apt-key present $name"],
  }

  case $ensure {
    present: {
      exec { "apt-key present $name":
        command	=> "/usr/bin/apt-key add /root/apt/keys/${keyid}.asc",
        unless	=> "/usr/bin/apt-key list | /bin/grep -c $keyid",
      }
    }
    absent: {
      exec { "apt-key absent $name":
        command => "/usr/bin/apt-key del $keyid",
        onlyif	=> "/usr/bin/apt-key list | /bin/grep -c $keyid",
      }
    }
    default: {
      fail "Invalid 'ensure' value '$ensure' for apt::source::key."
    }
  }
}
