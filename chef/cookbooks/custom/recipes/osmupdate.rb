#
# Cookbook Name:: custom
# Recipe:: osmupdate
#

################################################################################
# execute osmupdate to patch an osm pbf file to the most current data

Array(node['osmupdate']).each do |cmd|

  # filename
  filename = cmd['filename']

  # set default environment or accept a custom env
  defaults = { 'HOME' => "/home/#{cmd['user']}" }
  environment = cmd['environment'] ? defaults.merge(cmd['environment']) : defaults

  # exec command
  execute("osmupdate #{filename}") do
    user          cmd['user']           if cmd['user']
    group         cmd['group']          if cmd['group']
    cwd           cmd['cwd']            if cmd['cwd']
    environment   environment
    command       <<-EOH
      osmupdate #{filename} updated-#{filename} &&
      rm #{filename} &&
      mv updated-#{filename} #{filename} &&
      chmod 644 #{filename}
    EOH
  end
end
