class apache::params inherits apache::version {

  $servertokens_default='Prod'
  $timeout_default=30
  $keepalive_default=true
  $keepalivetimeout_default=1
  $maxkeepalivereq_default=1000
  $extendedstatus_default=true
  $mpm_default='prefork'
  $serversignature_default=false
  $server_admin_default='root@localhost'

  case $::osfamily
  {
    'redhat':
        {
          $baseconf='/etc/httpd'
          $modulesdir='modules'
          $loadmodules_extra=true
          $apache_username='apache'
          $apache_group='apache'
          $load_mpm_prefork=false
          $apache24=false
          $modssl_package= [ 'mod_ssl' ]
          $logdir='/var/log/httpd'
          $rotatelogsbin='/usr/sbin/rotatelogs'

          $fastcgi_dependencies= [ 'make', 'gcc', 'gcc-c++' ]

          $sysconfigfile=undef
          $sysconfigtemplate=undef

          $packagename=[ 'httpd' ]
          $packagenamedevel='httpd-devel'
          $servicename='httpd'
          $conftemplate='httpdconfcentos6.erb'
          $conffile='conf/httpd.conf'

          $modphp_pkg=undef
          $modphp_so=undef


      case $::operatingsystemrelease
      {
        /^5.*/:
        {
          $rundir='/var/run'
        }
        /^[6-7].*$/:
        {
          $rundir='/var/run/httpd'
        }
        default: { fail('Unsupported RHEL/CentOS version!')  }
      }
    }
    'Debian':
    {
      #
      # QUICK & DIRTY
      #

      $baseconf='/etc/apache2'
      $modulesdir='/usr/lib/apache2/modules'
      $loadmodules_extra=false
      $apache_username='www-data'
      $apache_group='www-data'
      $load_mpm_prefork=true
      $apache24=true
      $logdir='/var/log/apache2'
      $rotatelogsbin='/usr/bin/rotatelogs'
      $rundir='/var/run/apache2'

      $fastcgi_dependencies=undef

      $sysconfigfile='/etc/apache2/envvars'
      $sysconfigtemplate="${module_name}/sysconfig/debian/envvars.erb"

      $modphp_pkg=[ 'libapache2-mod-php5' ]
      $modphp_so='libphp5.so'

      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
              $packagename=[ 'apache2', 'apache2-mpm-prefork', 'apache2-utils', 'lynx-cur' ]
              $packagenamedevel=undef
              $servicename='apache2'
              $conftemplate='httpdconfcentos6.erb'
              $conffile='apache2.conf'
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}