class apt {
  $default_server = "us.archive.ubuntu.com"
  $get = "/usr/bin/apt-get"

  exec { "$get update":
    require	=> File['/etc/apt/sources.list'],
    subscribe	=> File['/etc/apt/sources.list'],
    refreshonly => true,
  }

  file { '/etc/apt/sources.list':
    ensure	=> file,
    content	=> template("apt/sources.list.erb"),
    owner	=> root,
    group	=> root,
    mode	=> 644,
  }

  file { '/etc/apt/sources.list.d':
    ensure	=> directory,
    owner	=> root,
    group	=> root,
    mode	=> 644,
  }

  file { "/root/apt":
    ensure	=> directory,
    owner	=> root,
    group	=> root,
    mode	=> 644,
  }

  file { "/root/apt/keys":
    ensure	=> directory,
    owner	=> root,
    group	=> root,
    mode	=> 644,
  }
}
