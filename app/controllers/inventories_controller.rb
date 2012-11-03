class InventoriesController < GlintSearchController
	protected

	def klass
		Inventory
	end

	def default_order
		:short_title
	end
end
