class nginx {

  package {'nginx':
    ensure => present,
  }

  file {'/etc/nginx/nginx.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }

  file {'nginxDocRoot':
    ensure => directory,
    path   => '/var/www',
    owner  => 'root',
    group  => 'root',
    mode   => '0775',
  }

  file {'/var/www/index.html':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/nginx/index.html',
  }

  #file {'/etc/nginx/conf.d':
  #  ensure => directory,
  #  owner  => 'root',
  #  group  => 'root',
  #  mode   => '0775',
  #}

  file {'/etc/nginx/conf.d/default.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
  }

  service {'nginx':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/nginx/nginx.conf', '/etc/nginx/conf.d/default.conf'],
  }

}
