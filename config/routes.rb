Rails.application.routes.draw do


  get 'iscsi/index'

  get 'nfs/index'

  get 'fstab/index'
  get 'fstab/remove'
  
  get 'samba/index'
  get 'samba/install'
  get 'samba/delete'
  
  post 'samba/createshare' => "samba#createshare", :via => :post, :as => :samba_createshare

  get 'firewall/index'
  get 'firewall/removeservice', :via => :get, :as => :firewall_removeservice
  get 'firewall/removeport' => "firewall#removeport", :via => :get, :as => :firewall_removeport
  post 'firewall/addservice' => "firewall#addservice", :via => :post, :as => :firewall_addservice
  post 'firewall/addport' => "firewall#addport", :via => :post, :as => :firewall_addport
  
  get 'httpd/index'
  get 'httpd/nohttpd'
  get 'httpd/install'
  
  post 'httpd/create' => "httpd#create", :via => :post, :as => :httpd_create
  post 'httpd/advance' => "httpd#advance", :via => :post, :as => :httpd_advance
  get 'httpd/delete' => "httpd#delete", :via => :get, :as => :httpd_delete
  get 'repo/index'
  get 'repo/disable' => "repo#disable", :via => :get, :as => :repo_disable
  get 'usermanagement/index'
  post 'usermanagement/create' => "usermanagement#create", :via => :post, :as => :usermanagement_create
  get 'usermanagement/destroy/:username' => "usermanagement#destroy", :via => :get, :as => :usermanagement_destory
  get 'dashboard/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
