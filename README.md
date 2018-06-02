# wavinfo
Reads wav file info using a gem and displays it - or generates assimil8or presets.

The wavinfo script just outputs info about a .wav file to the terminal. It is based on https://github.com/jstrait/wavefile/blob/master/examples/info.rb but adds info from the smpl chunk (Loop data)

The make-assimilator-preset.rb script generates very basic preset file for the Russom Assimil8or sampler
It takes two arguments: a wavefilename and a presetname
The wavefile will be analyzed for loops, and if any exist, the first one will
be specified in the preset, since the assimil8or does not read loop info from samples.
