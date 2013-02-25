require 'redmine'
#require 'dispatcher'

Redmine::Plugin.register :redmine_embedded_video do
 name 'Redmine Embedded Video'
 author 'Nikolay Kotlyarov, PhobosK, Jan Pilz'
 description 'Embeds attachment videos, video URLs or Youtube videos. Usage (as macro): video(ID|URL|YOUTUBE_URL). Updated to JW Player 6.2.3115, SWFObject removed'
 url 'http://www.redmine.org/issues/5171'
 version '0.0.3.1'
end

Redmine::WikiFormatting::Macros.register do
   desc "Wiki video embedding"

    macro :video do |o, args|
        @width = args[1].gsub(/\D/,'') if args[1]
        @height = args[2].gsub(/\D/,'') if args[2]
        @width ||= 400
        @height ||= 300
        @num ||= 0
        @num = @num + 1
        attachment = o.attachments.find_by_filename(args[0]) if o.respond_to?('attachments')

        if attachment
            file_url = url_for(:only_path => false, :controller => 'attachments', :action => 'download', :id => attachment, :filename => attachment.filename)
        else
            file_url = args[0].gsub(/<.*?>/, '').gsub(/&lt;.*&gt;/,'')
        end
out = <<END
<script type="text/javascript" src="#{request.protocol}#{request.host_with_port}#{ActionController::Base.relative_url_root}/plugin_assets/redmine_embedded_video/jwplayer.js"></script>
<div id="video_#{@num}">Loading the player ...</div>
<script type="text/javascript">
    jwplayer("video_#{@num}").setup({
        file: "#{file_url}",
        height: #{@height},
        width: #{@width} 
    });
</script>
END

    out.html_safe
  end
end
