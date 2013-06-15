define sublime-text2::download-plugin($user, $gitUrl) {

  $packagePath = "/Users/$user/Library/Application Support/Sublime Text 2/Packages"

  exec { "sublime-package-${name}":
    command => "/usr/bin/git clone ${gitUrl} ${name}",
    creates => "${packagePath}/${name}/",
    cwd     => $packagePath,
    user    => $user
  }
}
