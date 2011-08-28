module RecordHelper
  def list_attributes(record, *attributes)
    content_tag :ul, :class => 'attribute_list' do
      attributes.collect do |attribute|
        content_tag :li do
          content_tag(:span, record.class.human_attribute_name(attribute) + ":", :class => 'attribute_name') + " " + content_tag(:span, record.send(attribute), :class => 'value')
        end
      end.join('').html_safe
    end
  end
end