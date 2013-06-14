# Install Sublime text with puppet
#
# class { 'sublime-text2':
#   source => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1.dmg',
#   cmdLine => true,
#   plugins => []
# }
class sublime-text2 ($user, $source, $cmdLine = false, $plugins = []) {
    package { 'Sublime Text 2':
        provider => appdmg,
        ensure => present,
        source => $source
    }

    file { ["/Users/$user/Library/Application Support/Sublime Text 2",
            "/Users/$user/Library/Application Support/Sublime Text 2/Packages",
            "/Users/$user/Library/Application Support/Sublime Text 2/Packages/User",
            "/Users/$user/bin"]:
      ensure => directory,
      require => Package['Sublime Text 2']
    }

    file { "/Users/$user/.sublime-settings":
        ensure => present,
        replace => false,
        content => template('sublime-text2/sublime-settings.erb')
    }

    file { "/Users/$user/Library/Application Support/Sublime Text 2/Packages/User/Preferences.sublime-settings":
        ensure => link,
        force => true,
        target => "/Users/$user/.sublime-settings",
        require => File["/Users/$user/Library/Application Support/Sublime Text 2/Packages/User"]
    }

    file { "/Users/$user/.sublime-packages":
        ensure => present,
        replace => false,
        content => template('sublime-text2/package-control.erb')
    }

    file { "/Users/$user/Library/Application Support/Sublime Text 2/Packages/User/Package Control.sublime-settings":
        ensure => link,
        force => true,
        target => "/Users/$user/.sublime-packages",
        require => File["/Users/$user/Library/Application Support/Sublime Text 2/Packages/User"]
    }

    if $cmdLine {
        file { "/Users/$user/bin/subl":
            ensure => link,
            require => File["/Users/$user/bin"],
            target => '/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl'
        }
    }

    sublime-text2::download-package { "Package Control":
        user => $user,
        url => "http://sublime.wbond.net/Package%20Control.sublime-package",
        filename => "Package%20Control.sublime-package",
        require => Package['Sublime Text 2']
    }
}
