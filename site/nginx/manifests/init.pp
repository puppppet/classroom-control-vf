class nginx (
  $docRoot = '/var/www',
) {

  $confDir = '/etc/nginx'

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  package {'nginx':
    ensure => present,
  }

  file {'/etc/nginx/nginx.conf':
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }

  #  file {'nginxDocRoot':
  #    ensure => directory,
  #    path   => '/var/www',
  #  }

  file { $docRoot:
    ensure => directory,
    path   => $docRoot,
  }

  file {"${docRoot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }

  file {'/etc/nginx/conf.d':
    ensure => directory,
  }

  file {'/etc/nginx/conf.d/default.conf':
    ensure  => file,
    #source => 'puppet:///modules/nginx/default.conf',
    content => template('nginx/default.conf.erb'),
    require => Package['nginx'],
  }

  service {'nginx':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/nginx/nginx.conf', '/etc/nginx/conf.d/default.conf'],
  }

}
