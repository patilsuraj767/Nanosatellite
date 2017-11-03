class HttpdController < ApplicationController
  def index
	
    x = `ls /usr/lib/systemd/system | grep httpd.service`
    if x != ""
			conffiles = `ls /etc/httpd/conf.d/nano*`
			@list = []
			split = conffiles.split(" ")
			split.each do |i|
				servername = `cat #{i} | grep -i servername | awk '{print $2}'`
				documentroot = `cat #{i} /etc/httpd/conf.d/one.conf | grep -i documentroot | awk '{print $2}'`
				portno = `cat #{i} | grep -i '^<virtualhost' | awk -F ':' '{print $2}' | sed 's/[^0-9]*//g'`
				@list << {
				:file => i,
        :servername => `cat #{i} | grep -i servername | awk '{print $2}'`,
        :documentroot => `cat #{i}  | grep -i documentroot | awk '{print $2}'`,
        :port => `cat #{i} | grep -i '^<virtualhost' | awk -F ':' '{print $2}' | sed 's/[^0-9]*//g'`
       }	
			end
			
			@json = JSON.parse(@list.to_json)
		
       render 'index'
    else
	     render 'nohttpd'
    end
  end
  
  def install 
    if `yum install httpd -y`
        render 'index'
    else
        render plain: "Error in install httpd"
    end
  
  end
	
	def create
    getservername = params[:servername]
    getdocumentroot = params[:documentroot]
		getport = params[:port]
    
		system("mkdir -p #{getdocumentroot}")
		
		zz = getservername.split('.')
		xyz = system("ls /etc/httpd/conf.d/nano#{zz[0]}")
		if xyz != "true"
			x = `echo -e "<VirtualHost *:#{getport}> \n ServerName #{getservername} \n DocumentRoot #{getdocumentroot} \n <VirtualHost>" >> /etc/httpd/conf.d/nano#{zz[0]}.conf` 
			if x
				system("systemctl restart httpd")
				system("systemctl enable httpd")
				redirect_to httpd_index_path
			else
				render plain: "Error in creating virtualhost"
			end
			
		else
			render plain: "Error server already"
		end
		
  end
	
	def advance
		requireip = params[:requireip]
    requirehost = params[:requirehost]
		if requireip == "" || requirehost == ""
		
		end
	end
	
	def delete
		xx = params[:server]
		zz = xx.split('.')
		system("rm -f /etc/httpd/conf.d/#{zz}.conf")
		system("systemctl restart httpd")
		
	end
  
end
