# Install Sublime text with puppet
#
# class { 'sublime-text2':
#   source => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1.dmg',
#   cmdLine => true,
#   plugins => []
# }
class sublime-text2 ($source, $cmdLine = false, $plugins = []) {
    package { 'Sublime Text 2':
        provider => appdmg,
        ensure => present,
        source => $source
    }

    file { "/Users/${id}/.sublime-settings":
        ensure => present,
        replace => false,
        content => template('sublime-text2/sublime-settings.erb')
    }

    file { "/Users/${id}/Library/Application Support/Sublime Text 2/Packages/User/Preferences.sublime-settings":
        ensure => link,
        force => true,
        target => "/Users/${id}/.sublime-settings",
        require => Package['Sublime Text 2']
    }

    file { "/Users/${id}/.sublime-packages":
        ensure => present,
        replace => false,
        content => template('sublime-text2/package-control.erb')
    }

    file { "/Users/${id}/Library/Application Support/Sublime Text 2/Packages/User/Package Control.sublime-settings":
        ensure => link,
        force => true,
        target => "/Users/${id}/.sublime-packages",
        require => Package['Sublime Text 2']
    }

    if $cmdLine {
        file { "/Users/${id}/bin/subl":
            ensure => link,
            require => Package['Sublime Text 2'],
            target => '/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl'
        }
    }

    sublime-text2::download-package { "Package Control":
        url => "http://sublime.wbond.net/Package%20Control.sublime-package",
        filename => "Package%20Control.sublime-package",
        require => Package['Sublime Text 2']
    }
}
