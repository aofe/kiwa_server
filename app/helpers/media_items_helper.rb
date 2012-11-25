module MediaItemsHelper
  def media_thumbnail(media_item, options = {})
    # Bail out unless we're passed a media item.
    # We include this check so we can easily use this function to show the primary image for a list of things that may or may not have an image
    return '' unless media_item
    
    # Set up default options, this allows us the options of specifying a size and/or a different object to link to than the larger image
    options.reverse_merge! :size => 100, :link_to => media_item.source_url + "kiwaserver/"
    
    link_to_if options[:link_to], image_tag(media_item.thumbnail_url(options[:size])), options[:link_to], 'data-preview' => media_item.thumbnail_url(700), :class => 'media_thumbnail' do
      content_tag :span, image_tag(media_item.thumbnail_url(options[:size])), :class => 'media_thumbnail'
    end
  end  
end
