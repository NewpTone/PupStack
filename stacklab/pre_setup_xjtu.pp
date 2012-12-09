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
host {'xjtu-1':
	name			=> 'xjtu-1.controller.edu',
	host_aliases	=> 'xjtu-1',
	ip				=> '123.139.159.3',
	}
host {'xjtu-2':
	name			=> 'xjtu-2.compute.edu',
	host_aliases	=> 'xjtu-2',
	ip				=> '123.139.159.4',
	}
host {'xjtu-3':
	name			=> 'xjtu-3.compute.edu',
	host_aliases	=> 'xjtu-3',
	ip				=> '123.139.159.5',
	}
host {'xjtu-4':
	name			=> 'xjtu-4.compute.edu',
	host_aliases	=> 'xjtu-4',
	ip				=> '123.139.159.7',
	}
host {'xjtu-5':
	name			=> 'xjtu-5.compute.edu',
	host_aliases	=> 'xjtu-5',
	ip				=> '123.139.159.13',
	}
host {'xjtu-6':
	name			=> 'xjtu-6.compute.edu',
	host_aliases	=> 'xjtu-6',
	ip				=> '123.139.159.15',
	}

class {'ntp':
	 servers    => [ 'ntp.sjtu.edu.cn' ],
	 autoupdate => false,
	 require    => Host['ntp-server']
}
