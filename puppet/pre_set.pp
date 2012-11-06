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
