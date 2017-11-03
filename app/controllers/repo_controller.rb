class RepoController < ApplicationController
  def index
    cmd  = `yum repolist enabled | sed -n '/repo id/,$p' | sed '$d' | awk '{print $1} BEGIN { ORS = ";;;" }'`
    @enabledrepo = cmd.split(";;;")
    
    cmd2  = `yum repolist disabled | sed -n '/repo id/,$p' | sed '$d' | awk '{print $1} BEGIN { ORS = ";;;" }'`
    @disabledrepo = cmd2.split(";;;")
    
  end
  
  def disable
    xxx = params[:repo]
    cmd = `logger #{xxx}`;
     redirect_to repo_index_path
    #render plain:  'Hello'
  end
end
