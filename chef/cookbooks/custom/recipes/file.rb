#
# Cookbook Name:: custom
# Recipe:: file
#

################################################################################
# write contents to file path

require 'json'

Array(node['file']).each do |file|

  # pretty print json
  content = file['format'] == "json" ? JSON.pretty_generate(file['content']) : file['content']

  file(file['path']) do
    atomic_update           file['atomic_update']           if file['atomic_update']
    backup                  file['backup']                  if file['backup']
    checksum                file['checksum']                if file['checksum']
    content                 content
    force_unlink            file['force_unlink']            if file['force_unlink']
    group                   file['group']                   if file['group']
    inherits                file['inherits']                if file['inherits']
    manage_symlink_source   file['manage_symlink_source']   if file['manage_symlink_source']
    mode                    file['mode']                    if file['mode']
    notifies                file['notifies']                if file['notifies']
    owner                   file['owner']                   if file['owner']
    path                    file['path']                    if file['path']
    provider                file['provider']                if file['provider']
    rights                  file['rights']                  if file['rights']
    sensitive               file['sensitive']               if file['sensitive']
    subscribes              file['subscribes']              if file['subscribes']
    verify                  file['verify']                  if file['verify']
    action                  file['action'] ? file['action'].to_sym : :create
  end
end
