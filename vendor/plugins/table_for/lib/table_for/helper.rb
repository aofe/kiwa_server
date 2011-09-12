module TableHelper
  # Simplest examle:
  # 
  #   <%= table_for @users do -%>
  #     <% columns :name, :email, :address %>
  #   <% end %>
  # 
  # Simple examle:
  # 
  #   <%= table_for @users, :http => { :class => "simple-table", :id => "users" } do -%>
  #     <% column :name %>
  #     <% column :email %>
  #     <% column :address %>
  #   <% end %>
  # 
  # More complex example:
  # 
  #   <%= table_for @users do -%>
  #     <% column :login, :title => "User name" %>
  #     <% column :email %>
  #     <% column :title => "Full name" do |user| %>
  #       <% [user.first_name, user.last_name].join(" ") %>
  #     <% end %>
  #     <% column :title => "Actions" do |user| %>
  #       <% link_to "Show", user %>
  #       <% link_to "Delete", user, :method => :delete %>
  #     <% end %>
  #   <% end %>
  #
  def table_for(records, *args, &block)
    raise ArgumentError, "Missing block" unless block_given?
    options = args.extract_options!
    raise ArgumentError, "Records should be array" unless records.respond_to? :each
    t = Table.new(self, records, options)
    block.call(t)
    t.draw
  end
end

ActionView::Base.class_eval do
  include TableHelper
end
