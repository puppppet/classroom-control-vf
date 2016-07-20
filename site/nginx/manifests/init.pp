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

  file {'/var/www':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '775',
    before => File['/etc/nginx/nginx.conf'],
  }

  service {'nginx':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/nginx/nginx.conf'],
  }

}
