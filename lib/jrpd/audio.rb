require_relative 'java_audio/audio_thread'

module JRPD
	class Audio

		def initialize(in_channels_count = 0, out_channels_count = 2, sample_rate = 44100, ticks_per_buffer = 16)
			@in_channels_count = in_channels_count
			@out_channels_count = out_channels_count
			@sample_rate = sample_rate
			@ticks_per_buffer = ticks_per_buffer
			@started = false
		end

		def start
			return if @started
			@audio_thread = JavaAudio::AudioThread.new(@in_channels_count, @out_channels_count, @sample_rate, @ticks_per_buffer)
			@audio_thread.start
			@started = true
		end

		def stop
			return unless @started
			@audio_thread.interrupt
			@audio_thread.join
			@started = false
		end

		def started?
			@started
		end

	end
end
