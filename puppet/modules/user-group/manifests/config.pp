class user-group::config{
    include nginx::install
    Class['nginx::install'] -> Class['user-group::config']

    group { 'demogroup':
        ensure => present,
        gid => 505,
    }

    user { 'demouser':
        ensure => present,
        gid => 'demogroup',
        comment => 'demouser',
        home => '/home/demouser',
        managehome => true,
        shell => '/bin/bash',
        require => Group["demogroup"]
    }

    file { '/home/demouser/.ssh':
        ensure => directory,
        owner => 'demouser',
        group => 'demogroup',
        mode => '0700',
        require => User["demouser"]
    }

    file { '/home/demouser/public':
        ensure => directory,
        owner => 'demouser',
        group => 'demogroup',
        mode => '0755',
        require => User["demouser"]
    }

    exec { "passwd" :
        user => 'root',
        path => ['/bin/','/usr/bin'],
        command => 'echo "demouser" | passwd --stdin demouser',
        timeout => 999,
        require => File['/home/demouser/.ssh']
    }

    exec { "chmod" :
        user => 'root',
        path => ['/bin'],
        command => "chmod 755 /home/demouser",
        timeout => 999,
        require => Exec['passwd']
    }

    exec { "usermod nginx" :
        user => 'root',
        path => ['/usr/sbin'],
        command => "usermod -G demogroup nginx",
        timeout => 999,
        require => Exec['chmod']
    }

}
