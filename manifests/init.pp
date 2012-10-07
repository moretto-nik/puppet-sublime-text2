# Install Sublime text with puppet
#
# class { 'sublime-text2':
#   source => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1.dmg',
#   preferences => '/Users/benji07/.sublime-settings',
#   cmdLine => true
# }
class sublime-text2 ($source, $preferences = undef, $cmdLine = false) {
    package { 'Sublime Text 2':
        provider => appdmg,
        ensure => present,
        source => $source
    }

    if $preferences != undef {
        file { "/Users/${id}/Library/Application Support/Sublime Text 2/Packages/User/Preferences.sublime-settings":
            ensure => link,
            force => true,
            target => $preferences,
            require => Package['Sublime Text 2']
        }
    }

    if $cmdLine {
        file { "/Users/${id}/bin/subl":
            ensure => link,
            require => Package['Sublime Text 2'],
            target => '/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl'
        }
    }
}

class {'sublime-text2':
    source => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1.dmg',
    preferences => '/Users/benji07/.sublime-settings',
    cmdLine => true
}
