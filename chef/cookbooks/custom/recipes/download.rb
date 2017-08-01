#
# Cookbook Name:: custom
# Recipe:: download
#

################################################################################
# download request source to file path

require 'json'

Array(node['download']).each do |req|

  remote_file(req['path']) do
    atomic_update           req['atomic_update']           if req['atomic_update']
    backup                  req['backup']                  if req['backup']
    checksum                req['checksum']                if req['checksum']
    force_unlink            req['force_unlink']            if req['force_unlink']
    ftp_active_mode         req['ftp_active_mode']         if req['ftp_active_mode']
    group                   req['group']                   if req['group']
    headers                 req['headers']                 if req['headers']
    inherits                req['inherits']                if req['inherits']
    manage_symlink_source   req['manage_symlink_source']   if req['manage_symlink_source']
    mode                    req['mode']                    if req['mode']
    notifies                req['notifies']                if req['notifies']
    owner                   req['owner']                   if req['owner']
    path                    req['path']                    if req['path']
    provider                req['provider']                if req['provider']
    rights                  req['rights']                  if req['rights']
    source                  req['source']                  if req['source']
    subscribes              req['subscribes']              if req['subscribes']
    use_conditional_get     req['use_conditional_get']     if req['use_conditional_get']
    use_etag                req['use_etag']                if req['use_etag']
    use_last_modified       req['use_last_modified']       if req['use_last_modified']
    verify                  req['verify']                  if req['verify']
    action                  req['action'] ? file['action'].to_sym : :create
  end
end
