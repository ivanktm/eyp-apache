define apache::custom_conf(
                    $source,
                    $filename = $name,
                    $replace  = true,
                  ) {

  if ! defined(Class['apache'])
  {
    fail('You must include the apache base class before using any apache defined resources')
  }

  file { "${apache::params::baseconf}/conf.d/${filename}.conf":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[$apache::params::packagename],
    notify  => Class['apache::service'],
    source  => $source,
    replace => $replace,
  }

}
