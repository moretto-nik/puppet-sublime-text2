define sublime-text2::download-package($user, $url, $filename) {

    $packagePath = "/Users/$user/Library/Application Support/Sublime Text 2/Packages"

    exec { "curl -O ${url}":
        cwd     => "/var/tmp",
        creates => "/var/tmp/${filename}",
        path    => ["/usr/bin", "/usr/sbin"]
    }

    exec { "unzip '/var/tmp/${filename}' -d '${packagePath}/${name}'":
        require => Exec["curl -O ${url}"],
        creates => "${packagePath}/${name}",
        path    => ["/usr/bin", "/usr/sbin"]
    }
}
