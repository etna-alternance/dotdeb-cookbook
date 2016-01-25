if node['lsb']['codename'].to_s.empty?
  Chef::Application.fatal!('The lsb-release package is required.')
end

unless node['dotdeb_repo']['repositories'].keys.include? node['lsb']['codename']
  Chef::Application.fatal!('A stable Debian system in version >= 6.0 is required.')
end

versions = node['dotdeb_repo']['repositories'][node['lsb']['codename']]

node.default['php_version'] = "5.6" unless node['php_version']

unless versions.keys.include? node['php_version']
    Chef::Application.fatal!("#{node['php_version']}: no such php version for #{node['lsb']['codename']}")
end

repositories = versions[node['php_version']]

repositories.each do |repository|
    apt_repository repository do
      uri 'http://packages.dotdeb.org'
      deb_src true
      distribution repository.gsub 'dotdeb', node['lsb']['codename']
      components ['all']
      arch 'amd64,i386'
      key 'http://www.dotdeb.org/dotdeb.gpg'
      action :add
    end
end

apt_preference 'dotdeb' do
  glob         '*'
  pin          'origin packages.dotdeb.org'
  pin_priority node['dotdeb_repo']['priority'].to_s
  only_if { repositories.length > 0 }
end
