#
# Cookbook Name:: custom
# Recipe:: npm
#

################################################################################
# execute npm commands listed in the 'npm' attribute

Array(node['npm']).each do |cmd|

  # set default command
  args = cmd['command'] || 'install --production'

  # set default environment or accept a custom env
  defaults = { 'HOME' => "/home/#{cmd['user']}" }
  environment = cmd['environment'] ? defaults.merge(cmd['environment']) : defaults

  # exec command
  execute("npm #{args}") do
    user          cmd['user']           if cmd['user']
    group         cmd['group']          if cmd['group']
    cwd           cmd['cwd']            if cmd['cwd']
    environment   environment
  end
end
