#
# Cookbook Name:: custom
# Recipe:: repos
#

include_recipe 'git'

################################################################################
# clone git repositories listed in the 'repos' attribute

Array(node['repos']).each do |repo|
  git(repo['destination']) do
    additional_remotes    repo['additional_remotes']  if repo['additional_remotes']
    checkout_branch       repo['checkout_branch']     if repo['checkout_branch']
    depth                 repo['depth']               if repo['depth']
    destination           repo['destination']         if repo['destination']
    enable_checkout       repo['enable_checkout']     if repo['enable_checkout']
    enable_submodules     repo['enable_submodules']   if repo['enable_submodules']
    environment           repo['environment']         if repo['environment']
    group                 repo['group']               if repo['group']
    notifies              repo['notifies']            if repo['notifies']
    provider              repo['provider']            if repo['provider']
    reference             repo['reference']           if repo['reference']
    remote                repo['remote']              if repo['remote']
    repository            repo['repository']          if repo['repository']
    revision              repo['revision']            if repo['revision']
    ssh_wrapper           repo['ssh_wrapper']         if repo['ssh_wrapper']
    subscribes            repo['subscribes']          if repo['subscribes']
    timeout               repo['timeout']             if repo['timeout']
    user                  repo['user']                if repo['user']
    action                repo['action'] ? repo['action'].to_sym : :sync
  end
end
