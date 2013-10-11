require 'java'
require_relative '../../../bin/libpd.jar'
require_relative '../../../bin/libpdbridge.jar'
JavaSoundThread = Java::UkCoOriginalprojectKadathLibpdbridge::JavaSoundThread

module JRPD
    module JavaAudio
        class AudioThread

            def initialize(in_channels_count, out_channels_count, sample_rate, ticks_per_buffer)
                @java_sound_thread = JavaSoundThread.new(sample_rate, out_channels_count, ticks_per_buffer)
            end

            def start
                @java_sound_thread.start
            end

            def interrupt
                @java_sound_thread.interrupt
            end

            def join
                @java_sound_thread.join
            end

        end
    end
end
