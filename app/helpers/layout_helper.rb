module LayoutHelper
	def site_menu
		MenuBar.new(self, :theme => 'site_menu') do |mb|
			mb.menu_bar_item link_to('Home', root_path)
			section_link(mb, SourceEncounter).selected(params[:controller] == 'encounters' && params[:type].to_s == 'Source')
			section_link(mb, AOFEEncounter).selected(params[:controller] == 'encounters' && params[:type].to_s == 'AOFE')
			section_link(mb, Voyage).selected(params[:controller] == 'voyages')
			section_link(mb, Person).selected(params[:controller] == 'people')
			section_link(mb, Label).selected(params[:controller] == 'labels')
			section_link(mb, Card).selected(params[:controller] == 'cards')
			section_link(mb, Inventory).selected(params[:controller] == 'inventories')
			section_link(mb, Expedition).selected(params[:controller] == 'expeditions')
			section_link(mb, Location).selected(params[:controller] == 'locations')
			mb.menu_bar_item link_to('Sign Out', destroy_user_session_path, :method => :delete, :id => 'sign_out'), :align => :right if user_signed_in?
		end
	end

  def section_link(menu_bar, klass)
    menu_bar.menu_bar_item(link_to klass.model_name.human.pluralize, klass)
  end

  def page_title(record)
  	record.display_name
  end
end