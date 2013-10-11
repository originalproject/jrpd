require 'minitest/autorun'
require_relative '../lib/jrpd'

class TestMessaging < MiniTest::Unit::TestCase

	def test_bang_sends_without_errors
		destination = JRPD::Destination.new('from_jrpd')
		destination.send_bang
	end

	def test_can_subscribe_to_bang_without_errors
		source = JRPD::Source.new('to_jrpd')
		source.subscribe_to_bang { }
	end

	def test_can_send_and_receive_bang_via_patch
		ok = false
		patch = JRPD::Patch.new('test/test_messaging.pd')
		source = JRPD::Source.new('to_jrpd')
		source.subscribe_to_bang { ok = true }
		destination = JRPD::Destination.new('from_jrpd')
		refute(ok)
		destination.send_bang
		sleep(0.1)
		assert(ok)
		patch.close
	end

	def test_can_send_and_receive_float_via_patch
		v = 0
		patch = JRPD::Patch.new('test/test_messaging.pd')
		source = JRPD::Source.new('to_jrpd')
		source.subscribe_to_float { |f| v = f }
		destination = JRPD::Destination.new('float_from_jrpd')
		assert_equal(0, v)
		destination.send_float(0)
		sleep(0.1)
		assert_equal(1, v)
		patch.close
	end

	def test_can_send_and_receive_symbol_via_patch
		v = ''
		patch = JRPD::Patch.new('test/test_messaging.pd')
		source = JRPD::Source.new('to_jrpd')
		source.subscribe_to_symbol { |s| v = s }
		destination = JRPD::Destination.new('from_jrpd')
		assert_equal('', v)
		destination.send_symbol('foo bar hoo hah')
		sleep(0.1)
		assert_equal('foo bar hoo hah', v)
		patch.close
	end

end
