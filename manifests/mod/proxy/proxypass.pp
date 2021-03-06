define apache::mod::proxy::proxypass(
                                      $servername,
                                      $destination,
                                      $vhost_order = '00',
                                      $port        = '80',
                                      $url         = $name,
                                    ) {
  #
  concat::fragment { "${apache::params::baseconf}/conf.d/sites/${vhost_order}-${servername}-${port}.conf.run proxypass ${url} ${destination}":
    target  => "${apache::params::baseconf}/conf.d/sites/${vhost_order}-${servername}-${port}.conf.run",
    content => template("${module_name}/proxy/proxypass.erb"),
    order   => '19',
  }
}
