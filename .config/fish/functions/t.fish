function t --wraps=command\ time\ -f\ \'\%e\ sec\' --description alias\ t=command\ time\ -f\ \'\%e\ sec\'
  command time -f '%e sec' $argv
        
end
