require 'minitest/autorun'
require_relative '../lib/jrpd'

class TestAudio < MiniTest::Unit::TestCase

	def test_audio_starts_and_stops_without_errors
		audio = JRPD::Audio.new
		audio.start
		sleep(1)
		audio.stop
	end

	def test_patch_opens_and_closes_without_errors
		patch = JRPD::Patch.new('test/test_audio.pd')
		patch.close
	end

	def test_patch_with_audio_works_without_errors
		# This should also make a sound, but I don't know how 
		# to test that and can't be bothered at this point.
		# I'm sure there is some truly horrifying Java audio
		# analysis library that would do the job...
		audio = JRPD::Audio.new
		patch = JRPD::Patch.new('test/test_audio.pd')
		audio.start
		sleep(1)
		patch.close
		audio.stop
	end

end
