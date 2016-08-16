class production {
    
    include 'vcsrepo'

    vcsrepo{ '/usr/src/server-app':
        ensure   => present,
        provider => git,
        require  => [ Package["git"] ],
        source   => 'https://github.com/ozzann/basic-ping-server',
    }

    package { 'git':
       ensure => installed,
    }

    include 'docker'
    $app_dir = '/usr/src/server-app'
    docker::image { 'server-app':
        docker_dir => $app_dir,
        require    => File[$app_dir],
        
    }

    docker::run {'server-app':
        detach => true,
        image  => 'server-app',
        require => Docker""Image['server-app'],
    }

    file { '/usr/src/server-app/Dockerfile':
        ensure => file,
        source => '/usr/src/server-app/Dockerfile',
    }


}

