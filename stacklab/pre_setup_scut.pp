# Useful config pre install Openstack

file {'/etc/apt/apt.conf.d/98unauth':
	ensure		=> present,
	content		=> 'APT::Get::AllowUnauthenticated "true";'
	}

apt::source { 'openstack_folsom':
  location          => "http://ubuntu-cloud.archive.canonical.com/ubuntu",
  release           => "precise-updates/folsom",
  repos             => "main",
}

apt::source{'stacklab':
  location          => "http://220.181.129.130/stacklab",
  release           => "binary/",
  repos             => "",
  pin               => "1001",
  include_src       => false
}

exec { '/usr/bin/apt-get update':
  refreshonly => true,
  subscribe   => [ Apt::Source["openstack_folsom"],Apt::Source["stacklab"]],
  logoutput   => true,
}


host {'ntp-server':
	name => 'ntp.sjtu.edu.cn',
	ip   => '202.120.2.101',
}

host {'stacklab-master':
	comment			=> 'Stacklab master node',
	name		    => 'center.stacklab.org',
	host_aliases	=> 'center',
	ip				=> '54.251.115.186',
}
host {'scut-1':
	name			=> 'scut1.controller.scut.edu',
	host_aliases	=> 'scut1',
	ip				=> '116.57.78.3',
	}

host {'scut-2':
	name			=> 'scut2.compute.scut.edu',
	host_aliases	=> 'scut2',
	ip				=> '116.57.78.4',
	}

host {'scut-3':
	name			=> 'scut3.compute.scut.edu',
	host_aliases	=> 'scut3',
	ip				=> '116.57.78.5',
	}

host {'scut-4':
	name			=> 'scut4.compute.scut.edu',
	host_aliases	=> 'scut4',
	ip				=> '116.57.78.6',
	}

host {'scut-5':
	name			=> 'scut5.compute.scut.edu',
	host_aliases	=> 'scut5',
	ip				=> '116.67.78.7',
	}

class {'ntp':
	 servers    => [ 'ntp.sjtu.edu.cn' ],
	 autoupdate => false,
	 require    => Host['ntp-server']
}
