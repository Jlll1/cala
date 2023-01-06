# cala
Cala is a simple, ~150 SLOC shell script to keep track of processes you want to run in the background.  
All it does is:
* create metadata about your command in ${HOME}/.cala/[id].cala (status, PID, command)
* redirect output of your command to ${HOME}/.cala/[id].cala.output
* chain your command with a command that will set its status to `Completed` after it's done


## Installing cala
The simplest way to install cala is to simply clone this repo and run the included makefile.
```
git clone https://github.com/Jlll1/cala
cd cala
sudo make install
```

## Usage
Cala provides two commands:
* `add <command>` - Executes `<command>` and starts tracking it. Returns `calaId` for the command.
* `list` - Lists out the contents of `~/.cala`, as well as updating any dead processes that weren't marked `Completed` to `Error`.

Cala does not provide built-in command to read the output of a command.  
You can do it by reading `~/.cala/<id>.cala.output`


Cala does not provide built-in command to clear tracked processes.  
You can do it by removing `~/.cala/<id>.cala.output` and `~/.cala/<id>.cala` for the processes you want to untrack  
or  
you can simply do `rm -r ~/.cala` to clear all tracked processes and reset `calaId` to 0.  


## Demo
![Peek 2023-01-06 15-47](https://user-images.githubusercontent.com/71319302/211035716-2a9831d3-6b86-4017-b210-85f452b8ff60.gif)

## Contributing
Contributions are more than welcome.  
I use this script in a very specific way, and it works fine for me, but I'm aware that there are some usecases that are not handled.  
Feel free to create an issue or open a pull request, it would be much appreciated.
