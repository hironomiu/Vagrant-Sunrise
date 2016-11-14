class php::service {
    include nginx::install
    Class['nginx::install'] -> Class['php::service']

    service{ 'php-fpm':
        enable => true,
        ensure => running,
        hasrestart => true,
    }

    exec { "firewall-cmd" :
        user => 'root',
        cwd => '/root',
        command => '/bin/firewall-cmd --add-service=http --permanent ; /bin/firewall-cmd --permanent --add-port=8080/tcp ; /bin/firewall-cmd --reload',
    }
}
