class FstabController < ApplicationController
  def index
    x = `cat /etc/fstab | sed '/#/d' | sed '/^$/d' | wc -l`
    puts x.to_i
    
    @list = []
    i=1
    while i <= x.to_i do
      puts `cat /etc/fstab | sed '/#/d' | sed '/^$/d' | sed -n #{i}p  | awk '{print $1}'`
      
      @list << {
				  :disk => `cat /etc/fstab | sed '/#/d' | sed '/^$/d' | sed -n #{i}p  | awk '{print $1}'`,
	 				:mountpt => `cat /etc/fstab | sed '/#/d' | sed '/^$/d' | sed -n #{i}p  | awk '{print $2}'`,
	 				:filesystem => `cat /etc/fstab | sed '/#/d' | sed '/^$/d' | sed -n #{i}p  | awk '{print $3}'`,
					:mountoption => `cat /etc/fstab | sed '/#/d' | sed '/^$/d' | sed -n #{i}p  | awk '{print $4}'`,
					:dump => `cat /etc/fstab | sed '/#/d' | sed '/^$/d' | sed -n #{i}p  | awk '{print $5}'`,
					:fsck => `cat /etc/fstab | sed '/#/d' | sed '/^$/d' | sed -n #{i}p  | awk '{print $6}'`
       }
      i+=1
     end
    
     @json = JSON.parse(@list.to_json)
    
  end
  
   def remove
    
    end
    
end
