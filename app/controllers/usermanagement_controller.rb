class UsermanagementController < ApplicationController
  def index
    users = `cat /etc/passwd | awk -F : 'BEGIN { ORS = ";;;"} $3>999 ' `
    test = users.split(";;;")
    suser = Array.new
    @userlist = []
    test.each do |i|
      
      suser = i.split(":")
      @userlist << {
        :username => suser[0],
        :uid => suser[2],
        :gid => suser[3],
        :gecos => suser[4],
        :home => suser[5],
        :shell => suser[6]
       }
   end
    
    
    @json = JSON.parse(@userlist.to_json)
  end
  
  def create
    username = params[:username]
    password = params[:password]
    @useradd = `useradd #{username}`
    @passwd = `echo #{password} | passwd #{username} --stdin` 
    
  end
  
  def destroy
     username = params[:username]
     @userdel = `userdel #{username}` 
     render template: "usermanagement/destory"
  end
  
  
end
