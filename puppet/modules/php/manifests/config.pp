class php::config {
    file { '/etc/php.ini':
        owner => 'root', group => 'root',
        content => template('php/php.ini'),
    }
    file { '/etc/php.d/10-opcache.ini':
        owner => 'root', group => 'root',
        content => template('php/10-opcache.ini'),
    }
    file { '/etc/php-fpm.d/www.conf':
        owner => 'root', group => 'root',
        content => template('php/www.conf'),
    }
    file { '/etc/sysctl.conf':
        owner => 'root', group => 'root',
        content => template('php/sysctl.conf'),
    }
}
