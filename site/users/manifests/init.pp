class users {

  user { 'fundamentals':
    ensure => present,

  users::managed_user{ 'jose': }
  users::managed_user{ 'alice': }
  users::managed_user{ 'chen': }
  users::managed_user{ 'superman':
    group => ['staff', 'security']
  }

  group { 'staff':
    ensure => present,
  }
  group { 'security':
    ensure => present,
  }
}
