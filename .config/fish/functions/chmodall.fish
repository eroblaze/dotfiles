function chmodall --wraps='chmod a+rwx' --wraps='sudo chmod a+rwx' --description 'alias chmodall=sudo chmod a+rwx'
  sudo chmod a+rwx $argv
        
end
