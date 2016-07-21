class users::admins {

  users::managed_users{ 'jose': }
  users::managed_users{ 'alice': }
  users::managed_users{ 'chen': }
  users::managed_users{ 'superman':
    group => ['staff', 'security']
  }

  group { 'staff':
    ensure => present,
  }
  group { 'security':
    ensure => present,
  }
}
