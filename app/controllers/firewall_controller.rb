class FirewallController < ApplicationController
  def index
    x = `firewall-cmd --list-all | grep services`
    @test = x.split(" ")
    @test.delete_at(0)
    
    x2 = `firewall-cmd --list-all | grep -m 1 'ports'`
    @ports = x2.split(" ")
    @ports.delete_at(0)
  end
  
  def addservice
    service = params[:service]
    system("firewall-cmd --permanent --add-service=#{service}")
    system("firewall-cmd --reload")
    redirect_to firewall_index_path
  end
  
  def addport
    port = params[:fport]
    system("firewall-cmd --permanent --add-port=#{port}/tcp")
    system("firewall-cmd --reload")
    redirect_to firewall_index_path
  end
  
  def removeservice
    service = params[:service]
    
    system("firewall-cmd --permanent --remove-service=#{service}")
    system("firewall-cmd --reload")
    redirect_to firewall_index_path
  end
  
  def removeport
    port = params[:fport]
    
    system("firewall-cmd --permanent --remove-port=#{port}")
    system("firewall-cmd --reload")
    redirect_to firewall_index_path
  end
end
