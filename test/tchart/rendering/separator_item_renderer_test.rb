require_relative '../../test_helper'

module TChart
  describe SeparatorItemRenderer, "render" do
    it "generates TeX code to render a separator" do
      chart = stub( x_axis_length: 20 )
      separator = stub( y_coordinate: 10 )
      renderer = SeparatorItemRenderer.new
      renderer.render(chart, separator).must_equal <<-EOS.unindent
        % horizontal separator line
        \\draw [draw = black!5] (0.00mm, 10.00mm) -- (20.00mm, 10.00mm);
      EOS
    end
  end
end