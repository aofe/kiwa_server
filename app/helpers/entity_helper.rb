module EntityHelper
	def entity(record, options = {})
		options.reverse_merge! :name => :display_name
		link_to record, :id => dom_id(record), :class => record.class.model_name.underscore  do
			content_tag(:span, record.send(options[:name]), :class => 'name')
		end
	end

	def entity_list(records, options = {})
		''.html_safe.tap do |output|
			records.each do |record|
				output << entity(record, options)
			end
		end
	end
end