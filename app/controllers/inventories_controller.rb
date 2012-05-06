class InventoriesController < GlintSearchController
	protected

	def klass
		Inventory
	end

	def order
		:short_title
	end
end
