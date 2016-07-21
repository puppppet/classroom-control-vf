define users::managed_user {

  $homedir = "/home/${title}",
  $group = "${title}",

  File {
    owner = $title,
    group = $title,
    mode = '0644'
  }

  user { $title:
    ensure => present,
  }

  file {"${homedir}":
    ensure => directory,
    }

  file {'{$homedir}/.ssh':
    ensure => directory,
  }

}
