# Downloads and installs Wildfly from a remote source or a system package.
class wildfly::install {
  if $wildfly::package_name {
    package { $wildfly::package_name :
      ensure => $wildfly::package_version,
    }
  } else {
    $install_source = $wildfly::install_source
    $install_file = basename($install_source)

    file { "${wildfly::install_cache_dir}/${install_file}":
      source => $install_source,
    }

    # Gunzip+Untar wildfly.tar.gz if download was successful.
    ~> exec { "untar ${install_file}":
      command  => "tar --no-same-owner --no-same-permissions --strip-components=1 -C ${wildfly::dirname} -zxvf ${wildfly::install_cache_dir}/${install_file}", # lint:ignore:140chars
      path     => ['/bin', '/usr/bin', '/sbin'],
      loglevel => 'notice',
      creates  => "${wildfly::dirname}/jboss-modules.jar",
      user     => $wildfly::user,
      group    => $wildfly::group,
    }
  }
}
