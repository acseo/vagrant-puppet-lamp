node default {

	exec { "apt-update":
		command => 'apt-get update',
		path => ["/usr/bin", "/usr/sbin", "/usr/local/bin"],			
		before => Exec['apt-upgrade']
	}
	
	exec { "apt-upgrade":
		command => 'apt-get upgrade',
		path => ["/usr/bin", "/usr/sbin", "/usr/local/bin"],		
	}
	

	include git

	class { 'mysql::server':
  		config_hash => {
  			'root_password' => 'root', 
  			'bind_address' => '0.0.0.0', 
  		}
	}


	package {
		"apache2":
			ensure => present;	
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
	
	service { "apache2":
	    ensure  => "running",
	    enable  => "true",
	    require => Package["apache2"],
	}	



	exec { "a2enmod rewrite":
		command => 'a2enmod rewrite',
		path => ["/usr/bin", "/usr/sbin", "/usr/local/bin"],		
		require => Package["apache2"],
		notify  => Service["apache2"],
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
    
	file { '/usr/local/bin/vhost':
		ensure => 'file',
		source => 'puppet:///modules/site/common/vhost.sh',
		owner  => 'root',
		mode => '0744',
	}	
	
	file { '/var/www/index.php':
		ensure => 'file',
		source => 'puppet:///modules/site/common/index.php',
		owner  => 'root',
		require => Package["apache2"],
	}	
	
	file { '/var/www/index.html':
		ensure => 'absent',
		require => Package["apache2"],
	}	
	
	
    
}
