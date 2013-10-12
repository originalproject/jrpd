require 'minitest/autorun'
require_relative '../lib/jrpd'

class TestPatchMessaging < MiniTest::Unit::TestCase

  def test_can_add_objects_to_patch_using_send_message
    v = 0
    patch = JRPD::Patch.new('test/test_patch_messaging.pd')
    patch.send_message("obj", [100, 100, "r", "from_jrpd"])
    patch.send_message("obj", [100, 200, "s", "to_jrpd"])
    patch.send_message("connect", [0, 0, 1, 0])
    source = JRPD::Source.new('to_jrpd')
    source.subscribe_to_float { |s| v = s }
    destination = JRPD::Destination.new('from_jrpd')
    assert_equal(0, v)
    destination.send_float(1)
    sleep(0.1)
    assert_equal(1, v)
    patch.close
  end

  def test_can_add_objects_to_patch_using_send_unstructured_message
    v = 0
    patch = JRPD::Patch.new('test/test_patch_messaging.pd')
    patch.send_unstructured_message("obj 100 100 r from_jrpd")
    patch.send_unstructured_message("obj 100 200 s to_jrpd")
    patch.send_unstructured_message("connect 0 0 1 0")
    source = JRPD::Source.new('to_jrpd')
    source.subscribe_to_float { |s| v = s }
    destination = JRPD::Destination.new('from_jrpd')
    assert_equal(0, v)
    destination.send_float(1)
    sleep(0.1)
    assert_equal(1, v)
    patch.close
  end

  def test_can_make_a_patch_from_scratch
    skip # one day I will fucking figure this out
    v = 0
    pd = JRPD::Destination.new('pd')
    pd.send_message("filename", ["conjured_patch", "./"])
    patch = JRPD::Destination.new('pd-conjured_patch')    
    patch.send_message("obj", [100, 100, "r", "from_jrpd"])
    patch.send_message("obj", [100, 200, "s", "to_jrpd"])
    patch.send_message("connect", [0, 0, 1, 0])
    source = JRPD::Source.new('to_jrpd')
    source.subscribe_to_float { |s| v = s }
    destination = JRPD::Destination.new('from_jrpd')
    assert_equal(0, v)
    destination.send_float(1)
    sleep(0.1)
    assert_equal(1, v)
  end

end
