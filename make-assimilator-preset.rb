# This script generates very basic preset file for the Russom Assimil8or sampler
# It takes two arguments: a wavefilename and a presetname
# The wavefile will be analyzed for loops, and if any exist, the first one will
# be specified in the preset, since the assimil8or does not read loop info from samples.

# The wavefile fork may be fetched from https://github.com/henrikj242/wavefile
$LOAD_PATH.unshift "/Users/henrikjensen/Projects/wavefile/lib"
require 'wavefile'

include WaveFile

wav_file, preset_file = ARGV
preset_name = "#{wav_file.gsub('.wav', '')}"
puts "wav_file: #{wav_file}; preset_name: #{preset_name}; preset_file: #{preset_file}"

begin
  reader = Reader.new(wav_file)

  if reader.sample_info.nil?
    loop_start = nil
    loop_length = nil
  else
    loop_start = reader.sample_info.loops.first.start
    loop_length = reader.sample_info.loops.first.end - loop_start
  end

  if loop_start && loop_length
    yml = <<~END
Preset 1 :
  Name : #{preset_name}
  Channel 1 :
    LoopMode : 1
    Zone 1 :
      Sample : #{wav_file}
      LoopStart : #{loop_start}
      LoopLength :  #{loop_length}.0000
END

  else
    yml = <<~END
Preset 1 :
  Name : #{preset_name}
  Channel 1 :
    Zone 1 :
      Sample : #{wav_file}
END
  end

  File.open(preset_file, 'w') do |file|
    file.puts yml
  end

rescue InvalidFormatError
  puts "  Not a valid Wave file!"
end