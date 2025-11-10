function comp --wraps='g++ -std=c++20' --wraps='g++ -std=c++23' --description 'alias comp=g++ -std=c++23'
    g++ -std=c++23 $argv
end
