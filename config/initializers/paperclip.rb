Paperclip::Attachment.default_options[:use_timestamp] = false
require 'paperclip/media_type_spoof_detector'
module Paperclip
class MediaTypeSpoofDetector
def spoofed?
false
end
end
end