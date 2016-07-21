# Disable filebucket by default for all File resources:
File { backup => false }

# Randomize enforcement order to help understand relationships
ini_setting { 'random ordering':
  ensure  => present,
  path    => "${settings::confdir}/puppet.conf",
  section => 'agent',
  setting => 'ordering',
  value   => 'title-hash',
}

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
  notify { "Hello Silly, my name is most assuredly ${::hostname}": }#

  exec { 'welcome':
  command => "/usr/local/bin/cowsay 'Welcome to ${::fqdn}!' > /etc/motd", 
  creates => '/etc/motd',
  }
  
  host { 'testing.puppetlabs.vm':
  ensure => present,
  ip => '127.0.0.1',
  host_aliases => ['foo', 'foobar'],
  }

  #Exercise 9.2 - declare the fundamentals user
  #include users

  #Exercise 9.3 - declare the /etc/skeleton module
  include skeleton
 
}

node 'puppppet.puppetlabs.vm' {

  include memcached
  include skeleton
  include nginx

  if $facts['is_virtual'] == true {

    $upper = capitalize($facts['virtual'])

    notify { "This is a virtual machine of type: ${upper}": }
  } else {

    notify { "This is NOT a virtual machine": }
  }
}
