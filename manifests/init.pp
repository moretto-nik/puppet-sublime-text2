# Install Sublime text with puppet
#
# class { 'sublime-text2':
#   source => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1.dmg',
#   cmdLine => true,
# }
class sublime-text2 ($source, $cmdLine = false) {
    package { 'Sublime Text 2':
        provider => appdmg,
        ensure => present,
        source => $source
    }

    file { "/Users/${id}/Library/Application Support/Sublime Text 2/Packages/User/Preferences.sublime-settings":
        ensure => link,
        force => true,
        target => '/Users/${id}/.sublime-settings',
        require => Package['Sublime Text 2']
    }

    file { "/Users/${id}/Library/Application Support/Sublime Text 2/Packages/User/Package Control.sublime-settings":
        ensure => link,
        force => true,
        target => '/Users/${id}/.sublime-packages',
        require => Package['Sublime Text 2']
    }

    if $cmdLine {
        file { "/Users/${id}/bin/subl":
            ensure => link,
            require => Package['Sublime Text 2'],
            target => '/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl'
        }
    }

    file { "Package Control.sublime-package":
        path => "/Users/${id}/Library/Application Support/Sublime Text 2/Packages/Package Control.sublime-package"
        ensure => present,
        source => http://sublime.wbond.net/Package%20Control.sublime-package,
        require => Package['Sublime Text 2'],
    }
}

class {'sublime-text2':
    source => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1.dmg',
    cmdLine => true
}
