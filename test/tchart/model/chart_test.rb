require_relative '../../test_helper'

module TChart
  describe Chart, "x_axis_length" do
    it "returns the correct length" do
      settings = stub( chart_width: 100, x_label_width: 10, y_label_width: 20 )
      items = stub
      chart = Chart2.new(settings, items)
      chart.x_axis_length.must_equal settings.chart_width - settings.y_label_width - settings.x_label_width
    end
  end
  
  describe Chart, "y_axis_length" do
    it "returns the correct length" do
      settings = stub( line_height: 10 )
      items = [ stub, stub ]
      chart = Chart2.new(settings, items)
      chart.y_axis_length.must_equal settings.line_height * (items.length + 1)
    end
  end
  
  describe Chart, "x_axis_labels" do
    it "calls XLabelsBuilder#build" do
      settings = stub
      items = stub
      chart = Chart2.new(settings, items)
      XLabelsBuilder.expects(:build2).with(chart)
      chart.x_axis_labels
    end
    it "caches the result" do
      settings = stub
      items = stub
      chart = Chart2.new(settings, items)
      XLabelsBuilder.expects(:build2).once.with(chart).returns(stub)
      chart.x_axis_labels
      chart.x_axis_labels
    end
  end
  
  describe Chart, "calc_layout" do
    it "invokes 'calc_layout' on each item" do
      settings = stub( line_height: 10 )
      items = [ stub, stub ]
      chart = Chart2.new(settings, items)
      items[0].expects(:calc_layout).with(chart, 20)
      items[1].expects(:calc_layout).with(chart, 10)
      chart.calc_layout
    end
  end
end
