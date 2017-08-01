#
# Cookbook Name:: custom
# Recipe:: dirs
#

################################################################################
# create directories listed in the 'directory' attribute

Array(node['directory']).each do |dir|
  directory(dir['path']) do
    group       dir['group']        if dir['group']
    inherits    dir['inherits']     if dir['inherits']
    mode        dir['mode']         if dir['mode']
    notifies    dir['notifies']     if dir['notifies']
    owner       dir['owner']        if dir['owner']
    path        dir['path']         if dir['path']
    provider    dir['provider']     if dir['provider']
    recursive   dir['recursive']    if dir['recursive']
    rights      dir['rights']       if dir['rights']
    subscribes  dir['subscribes']   if dir['subscribes']
    action      dir['action'] ? dir['action'].to_sym : :create
  end
end
