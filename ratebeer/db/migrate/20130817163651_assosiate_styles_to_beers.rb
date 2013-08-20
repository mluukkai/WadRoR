class AssosiateStylesToBeers < ActiveRecord::Migration
  # does not work...
  def up
    styles = Beer.all.each.map{ |b| b.style }.uniq
    styles.each do |style|
      Style.create :name => style
    end

    add_column :beers, :style_id, :integer
    rename_column :beers, :style, :style_name

    Beer.all.each do |beer|
      style = Style.find_by_name(beer.style_name)
      beer.style_id = style.id unless style.nil?
      beer.save
    end

    remove_column :beers, :style_name
  end

  def down
    add_column :beers, :style_name, :string

    Beer.all.each do |beer|
      style = Style.find beer.style_id
      beer.style_name = style.name
      beer.save
    end

    remove_column :beers, :style_id
    rename_column :beers, :style_name, :style
  end
end
