class php::install{
    package{'epel-release':
        provider => 'yum',
        ensure => installed
    }
    
    package { 'remi-release':
        ensure   => installed,
        source   => 'http://rpms.famillecollet.com/enterprise/remi-release-7.rpm',
        provider => rpm,
        require  => Package['epel-release'],
    }

    package{ 
        'php':
        provider => 'yum',
        ensure => 'latest',
        install_options => ['--enablerepo=remi,remi-php70,epel','--noplugins'],
        require => Package['remi-release']
    }

    exec { "opcache" :
        user => 'root',
        cwd => '/root',
        path => ['/usr/bin','/bin'],
        command => "yum install -y --enablerepo=remi-php70 php-opcache",
        timeout => 999,
        require => Package['php']
    }

    package{
        [
        'php-cli',
        'php-common',
        'php-pdo',
        'php-mbstring',
        'php-mysqlnd',
        'php-devel',
        'php-fpm',
        'php-xml',
        'php-mcrypt',
        'libmcrypt',
        'siege',
        'openssh-clients',
        'wget',
        'git',
        'screen',
        'unzip',
        'make',
        'dstat',
        'emacs',
        'vim-enhanced',
        'tree',
        'sysstat',
        'perf',
        'cronie-noanacron',
        'npm',
        'htop',
        'lsof',
        ]:
        provider => 'yum',
        ensure => latest,
        install_options => ['--enablerepo=remi,remi-php70,epel','--noplugins'],
        require => Exec['opcache']
    }

    package{
        [
        'cronie-anacron',
        ]:
        ensure => purged,
        require => Package['remi-release']
    }

}
