class SambaController < ApplicationController
  def index
     x = `ls /usr/lib/systemd/system | grep smb.service`
    if x != ""
			shares = `cat /etc/samba/smb.conf | grep '\\['`
      splits = shares.split(" ")
      
 			@list = []
			
 			splits.each do |i|

				
				@list << {
				  :sharename => i,
	 				:path => `cat /etc/samba/smb.conf | grep '\[#{i}\]' -A 6 | grep -i path | awk '{print $3}'`,
	 				:browseable => `cat /etc/samba/smb.conf | grep '\[#{i}\]' -A 6 | grep -i browseable | awk '{print $3}'`,
					:validusers => `cat /etc/samba/smb.conf | grep '\[#{i}\]' -A 6 | grep -i 'valid users' | cut -d' ' -f4-`,
					:writelist => `cat /etc/samba/smb.conf | grep '\[#{i}\]' -A 6 | grep -i 'write list' | cut -d' ' -f4-`,		
					:readlist => `cat /etc/samba/smb.conf | grep '\[#{i}\]' -A 6 | grep -i 'read list' | cut -d' ' -f4-`
       }	
			end
			
			@json = JSON.parse(@list.to_json)
		
       render 'index'
    else
	     render 'nosamba'
    end
  end

  def install
    if `yum install samba samba-client -y`
        render 'index'
    else
        render plain: "Error in install samba"
    end
  end
  
  
  def delete
  	 share = params[:share]
		puts "====+++++====="
		puts share.gsub("]", "\\]").gsub("[", "\\[")
		`sed -i '/#{share.gsub("]", "\\]").gsub("[", "\\[")}/,/^\s*$/{d}' /etc/samba/smb.conf`
# 				if x
# 				system("systemctl restart smb nmb")
# 				system("systemctl enable smb nmb")
# 				redirect_to samba_index_path
# 			else
# 				render plain: "Error in deleting samba share"
# 			end
		redirect_to samba_index_path
  end
  
	def createshare
			sharename = params[:sharename]
			path = params[:path]
			browseable = params[:browseable]
			validusers = params[:validusers]
			readlist = params[:readlist]
			writelist = params[:writelist]
			puts sharename
			puts path
			puts browseable
			puts validusers
			puts readlist
			puts writelist
			x = `echo -e "[#{sharename}] \n path = #{path} \n browseable = #{browseable} \n validusers = #{validusers} \n readlist = #{readlist} \n writelist = #{writelist}" >> /etc/samba/smb.conf`
				if x
				system("systemctl restart smb nmb")
				system("systemctl enable smb nmb")
				redirect_to samba_index_path
			else
				render plain: "Error in creating samba share"
			end
		
		
	end
  
end
