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
	name => 'sws-yz-10.master.com',
	ip	 => '123.126.53.170',
}

class {'ntp':
	 servers    => [ 'ntp.sjtu.edu.cn' ],
	 autoupdate => false,
	 require    => Host['ntp-server']
}
