#
# Cookbook:: icingaweb2
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#

include_recipe 'icinga2repo::default'

if %w[redhat centos].include?(node['platform']) && node['icingaweb2']['setup_epel']
  include_recipe 'yum-epel'
elsif node['platform'] == 'amazon'
  package 'epel-release'
  package 'bash-completion' do
    options '--enablerepo=epel'
  end
end

case node['icingaweb2']['web_engine']
when 'apache'
  include_recipe 'icingaweb2::apache'
else
  raise "unknown web engine '#{node['icingaweb2']['web_engine']}'"
end

include_recipe 'icingaweb2::packages'
include_recipe 'icingaweb2::install'

include_recipe 'icingaweb2::ido'