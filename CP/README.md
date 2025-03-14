# FILES

- `download_prob.py`: Used to receive responses from Competitive Companion and
  calls `make_prob.sh` using these data.

- `make_prob.sh`: Shell script that creates a folder using the name
  provided and populates it with the content of your
  `~/programming/.template/` directory.

- `.template/`: Contains files which will be used in all your
  subdirectories e.g: Makefiles, template files, e.t.c.

# USAGE

- Make sure the `time` command from `gnu` is installed so the formatting of the output will work.

1. Firstly, move all the script files into a folder e.g `mkdir ~/programming/`.

2. Create a folder where all the problem folders will be stored.
   If it's for CodeForces, it might be `~/programming/CF` then navigate into the folder and carry out the next step.

3. Run `~/programming/download_prob.py`. This will listen for Competitive Companion's response from the browser. Head over to your browser and click the Competitive Companion button to send the data. Note you can specify the number of questions to receive using the `-n` option. You can also rename the problem names on the spot using: `~/programming/download_prob.py one two three`

4. For each problem, a corresponding folder will be created containing a copy of all the files in your `~/programming/.template/` folder and also the input and output files fetched from Competitive Companion.

5. You can run your code using the Makefile in each problem directory:

**NOTE**: These commands will automatically create a `.precomputed_headers/` directory if no one is found in the current folder.

# COMMANDS

- `make test` -> Compiles your code and runs the executable file with all the `.in` files. Then it runs the `output` command ([My custom lightweight version of `diff`](https://github.com/eroblaze/fish-scripts)) for each `.res` && `.out` files and prints out the differences if any.
- `make run` -> Compiles your code and runs the executable file prompting you for input if needed
- `make runs` -> Compiles your code and executes the executable file passing every `.in` file to it one by one. It creates a corresponding `.res` file containing the output of your code.
- `make solve` -> Same as `make runs`.
- `make all` -> Compiles your code but doesn't run the executable file.
- `make clean` -> Deletes the executable file and the `.precomputed_headers/` directory.
- `make veryclean` -> Deletes the executable file, the `.precomputed_headers/` directory and the \*.res files
- `make rebuild` -> calls `make clean` and `make all`.
