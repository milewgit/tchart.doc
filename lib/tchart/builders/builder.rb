module TChart
  module Builder
    
    def self.build(layout, items)
      x_items = Builder.build_x_items(layout)

      # TODO: see if there is a way of collecting the arrays without using 'elements'
      elements = []
      x_items
        .zip(layout.x_item_x_coordinates)
        .each { |item, x| elements += item.build(layout, x) }
      items
        .zip(layout.y_item_y_coordinates)
        .each { |item, y| elements += item.build(layout, y) }
      elements
    end
    
    def self.build_frame(items)
      [ YSeparator.new ] + items + [ YSeparator.new ]
    end
    
    def self.build_x_items(layout)
      layout.x_item_dates.map { |year| XItem.new(year) }
    end
      
  end
end
