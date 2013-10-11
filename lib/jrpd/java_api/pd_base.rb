require_relative 'libpd'

module JRPD::JavaApi
  PdBase = Java::OrgPuredataCore::PdBase
end

=begin
module JRPD
	module JavaApi
		module PdBase

			def self.set_receiver(receiver)
                JavaPdBase.setReceiver(receiver)
            end

            def self.open_patch(patch_path)
                JavaPdBase.openPatch(patch_path)
            end

            def self.close_patch(patch_id)
                JavaPdBase.closePatch(patch_id)
            end

            def self.send_bang(receiver_name)
                JavaPdBase.sendBang(receiver_name)
            end

            def self.send_float(receiver_name, value)
                JavaPdBase.sendFloat(receiver_name, value)
            end

            def self.send_symbol(receiver_name, value)
                JavaPdBase.sendSymbol(receiver_name, value)
            end

            def self.send_list(receiver_name, *values)
                JavaPdBase.sendList(receiver_name, values)
            end

            def self.send_message(receiver_name, message_type, *values)
                JavaPdBase.sendList(receiver_name, values)
            end

            def self.exists(subscription_name)
                JavaPdBase.exists(subscription_name)
            end

            def self.subscribe(subscription_name)
                JavaPdBase.subscribe(subscription_name)
            end

        end
    end
end
=end
