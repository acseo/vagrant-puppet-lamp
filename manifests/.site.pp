node default {

	exec { "apt-update":
		command => 'apt-get update',
		path => ["/usr/bin", "/usr/sbin", "/usr/local/bin"],			
	}

	Exec["apt-update"] -> Package <| |>

	include git

	class { 'mysql::server':
  		config_hash => {
  			'root_password' => 'root', 
  			'bind_address' => '0.0.0.0', 
  		}
	}

	class { 'apache':  }
	
	apache::vhost { 'project.local':
      port    => '80',
      docroot => '/var/www/project',
    }
	
	package {
		"memcached":
			ensure => present;							
		"php5":
			ensure => present,
			require => Package["apache2"];			
		"php5-mysql":
			ensure => present;
		"php5-curl":
			ensure => present;			
		"php5-mcrypt":
			ensure => present;
		"php5-gd":
			ensure => present;
		"php5-memcached":
			ensure => present;
		"imagemagick":
			ensure => present;		
		"php5-imagick":
			ensure => present;					
		"php-pear":
			ensure => present;	
		"libapache2-mod-php5":
			ensure => present,
			require => Package["php5"];
	}			
    
    class { 'composer':
        target_dir      => '/usr/local/bin',
        composer_file   => 'composer',
        download_method => 'curl', 
        logoutput       => false,
        tmp_path        => '/tmp',
        php_package     => 'php5-cli',
        curl_package    => 'curl',
        wget_package    => 'wget',
        composer_home   => '/root',
    }    
}
