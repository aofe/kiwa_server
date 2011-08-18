project_object_mapping = {
  :accession_number =>  :reported_acc_num,
  :name             =>  :proj_name,
  :place_of_origin  =>  :proj_origin,
  :indegenous_name  =>  :proj_indigenous_name,
  :material         =>  :proj_material,
  :description      =>  :proj_description,
  :dimensions       =>  :proj_dimensions
}

source_object_mapping = {
  :accession_number =>  :inst_acc_num,
  :unique_id        =>  :inst_unique_id,
  :part_count       =>  :inst_num,
  :name             =>  :inst_name,
  :place_of_origin  =>  :inst_origin,
  :indegenous_name  =>  :inst_indigenous_name,
  :material         =>  :inst_material,
  :description      =>  :inst_description,
  :dimensions       =>  :inst_dimensions
}

institution_mapping = {
  :id               =>  :id,
  :long_name        =>  :institution_long,
  :short_name       =>  :institution_short,
  :address          =>  :address,
  :city             =>  :city,
  :country          =>  :country,
  :url              =>  :url
}

inventory_mapping = {
  :id               =>  :id,
  :short_title      =>  :title_short,
  :long_title       =>  :title_long,
  :description      =>  :description
}

voyage_mapping = {
  :id               =>  :id,
  :expedition_id    =>  :inst_unique_id,
  :start_date       =>  :start_date,
  :end_date         =>  :end_date,
  :place_departed   =>  :departed,
  :place_returned   =>  :returned,
  :ship_name        =>  :ship_name,
  :ship_other_name  =>  :ship_other_name,
  :ship_tonnage     =>  :ship_tonnage,
  :ship_length      =>  :ship_length,
  :ship_beam        =>  :ship_beam,
  :ship_type        =>  :ship_type,
  :ship_cargo       =>  :ship_cargo
}


#  Encounter.delete_all
#  Artefact.delete_all
#  Institution.delete_all
Inventory.delete_all 
  
#if false
    SourceInventory.find_each do |source_inventory|
      Inventory.create! do |i|
        inventory_mapping.each do |target_field, source_field|
          i[target_field] = source_inventory[source_field]
        end
      end
    end
#end

if false 
  SourceInstitution.find_each do |source_institution|
    Institution.create! do |i|
      institution_mapping.each do |target_field, source_field|
        i[target_field] = source_institution[source_field]
      end
    end  
end

if false
  ProjectObject.includes(:relation => :source_object_data).each do |project_object|
    artefact = Artefact.create!(:institution_id => project_object.institution_id)

    # Create a en encounter for the project object
    Encounter.create! do |e|
      puts "Creating Encounter for project_object #{project_object.id}"

      e.artefact = artefact
      e.encounter_type = 'aofe'

      project_object_mapping.each do |enounter_field, source_field|
        e[enounter_field] = project_object[source_field]
      end
    end

    # If there is a source object data record too, make an encounter for that and link it to the same Artefact
    if project_object.relation and source_data = project_object.relation.source_object_data
      puts "Creating Encounter for source_object_data #{source_data.id}"
      Encounter.create! do |e|
        e.artefact = artefact
        e.encounter_type = 'source'

        source_object_mapping.each do |enounter_field, source_field|
          e[enounter_field] = source_data[source_field]
        end
      end    
    end
  end
end

if false
  SourceObjectData.includes(:relation).each do |source_object|
    if source_object.relation
      puts "#{source_object.id} - not created, is related"
      next
    end
    puts "Creating Encounter for source_object_data #{source_object.id}"
    artefact = Artefact.create!(:institution_id => source_object.institution_id)
    
    Encounter.create! do |e|
      e.artefact = artefact
      e.encounter_type = 'source'

      source_object_mapping.each do |enounter_field, source_field|
        e[enounter_field] = source_object[source_field]
      end
    end
  end
end