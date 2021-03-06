node default {

	exec { "apt-update":
		command => 'apt-get update',
		path => ["/usr/bin", "/usr/sbin", "/usr/local/bin"],			
	}

	Exec["apt-update"] -> Package <| |>

	include git

	class { 'mysql::server':
  		config_hash => {
  			'root_password' => '{{MYSQL_ROOT_PASSWORD}}', 
  			'bind_address' => '0.0.0.0', 
  		}
	}

 	mysql::db { '{{MYSQL_DB_NAME}}':
      user     => '{{MYSQL_USER}}',
      password => '{{MYSQL_PASSWORD}}',
      host     => 'localhost',
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

    class { 'apache': 
        mpm_module => 'prefork' 
    }
	
    class {  'apache::mod::php': }    
    class {  'apache::mod::rewrite': }
    
    apache::vhost { '{{APACHE_HOST_NAME}}':
      port    => '80',
      docroot => '{{APACHE_PROJECT_WEB_PATH}}',
    }
}
