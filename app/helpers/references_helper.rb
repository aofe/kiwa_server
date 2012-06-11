module ReferencesHelper
	def format_with_references(string)
		simple_format process_references(string)
	end

	def process_references(string)
		string = string.to_s
		string.gsub! /\{.+\}/ do |match|
			space = " ".html_safe
			begin
				case match.gsub(/[ {}]/,'') #remove whitespace, and the enclosing braces
				# Book
				when /B:(\d+):(.+)/
					space + text_reference(TextReference.find($1), $2)
				# Archival Source
				when /A:(\d+)(?::(.+))?/
					space + archival_reference(Archive.find($1), $2)
				# Digital Source
				when /D:(\d+):(.+)/
					space + "DigitalReference!!" + digital_reference(DigitalReference.find($1))
				# Inventory Source
				when /I:(\d+)/
					space + "Inventory!!" + inventory_reference(InventoryListEntry.find($1))
				# Researchers
				when /R:(\d+):(.+)/
					space + researcher_reference(Researcher.find($1))
				end
			rescue => e
				content_tag(:span, " [Reference Error: #{e.message}]", :style => 'color: red')
			end
		end

		return string.html_safe
	end

	def text_reference(reference, page_numbers)
		text = "(#{reference.author_name} #{reference.source_date.year} : [#{page_numbers}])"

		case reference.source_type
		when 'book'
			tooltip = "#{reference.author_name}. #{reference.author_initial} (#{reference.source_date.year}). #{reference.title}. #{reference.city}: #{reference.publisher}."
		when 'article'
			tooltip = "#{reference.author_name}. #{reference.author_initial} (#{reference.source_date.year}). #{reference.title}. #{reference.journal_title}, #{reference.volume} (#{reference.number}), pp. #{page_numbers}."
		when 'chapter'
			tooltip = "#{reference.author_name}. #{reference.author_initial} (#{reference.source_date.year}). #{reference.title}. In: #{reference.book_editor}. #{reference.book_title}. #{reference.city}: #{reference.publisher}, #{page_numbers}."
		when 'thesis'
			tooltip = "#{reference.author_name}. #{reference.author_initial} (#{reference.source_date.year}). #{reference.title}. #{reference.qualification}. #{reference.institution}/"
		end

		content_tag :span, text, :title => tooltip, :class => 'reference'
	end

	def archival_reference(reference, page_numbers = nil)
		text = page_numbers.present? ? "(#{reference.title_short} p. [#{page_numbers}])" : "(#{reference.title_short})"
		tooltip = "#{reference.title_short} (#{reference.start_date.try(:year)})-(#{reference.end_date.try(:year)}) #{reference.institution.long_name} #{reference.id_num}"

		content_tag :span, text, :title => tooltip, :class => 'reference'
	end

	def digital_reference(reference, date_accessed)
		case reference.format
		when 'database'
			text = "(#{reference.title}, [#{date_accessed}])"
		else
			text = reference.author_name.present? ? "(#{reference.host_name}, [#{date_accessed}])" : "(#{reference.author_name}, #{reference.source_date.year}, [#{date_accessed}])"
		end

		case reference.format
		when 'database'
			tooltip = "#{reference.institution_long}. Database: #{reference.title}."
		when 'website'
			tooltip = reference.author_name.present? ? "#{reference.author_name}. #{reference.title}" : "#{reference.host_name}. #{reference.title}"
		when 'pdf'
			tooltip = reference.author_name.present? ? "#{reference.author_name} #{reference.source_date}. #{reference.title}" : "#{reference.host_name} #{reference.source_date}. #{reference.title}"
		end
		
		tooltip << " [online] Available at: #{reference.host_name}, #{reference.url}" if reference.url.present?

		content_tag :span, text, :title => tooltip, :class => 'reference'
	end

	def inventory_reference(reference)
		content_tag :span, "(#{reference.inventory_list.short_title}: #{reference.inventory_list.description})", :class => 'reference'
	end

	def researcher_reference(reference)
		content_tag :span, "(#{reference.display_name})", :class => 'reference'
	end
end