class EncounterSearch < Glint::Search
	self.searchable_class = Encounter # Ensure the class is loaded when in dev mode

	def initialize(type, *args)
		@type = type
		super *args
	end

	def cache_key
		cache_prefix = ""
		cache_prefix << "type-#{@type}" if @type
		super(cache_prefix)
	end

	private

	def scope_results(solr)
	    solr.with(registered_facet(:type).solr_search_indices.values.first, @type.to_s.downcase) if @type	    # Scope to the given encounter type
	    super
	end
end