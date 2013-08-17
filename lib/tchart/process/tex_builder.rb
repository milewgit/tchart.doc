require 'stringio'

module TChart
  class TeXBuilder # TODO: rename to TikZBuilder
    
    def initialize
      @output = StringIO.new
    end
    
    def echo(text)
      @output << text
    end
    
    def comment(text)
      @output << "% #{escape_tex_special_chars text.to_s}\n"
    end
    
    def line(from, to, style)
      @output << "\\draw [#{style}] (#{f from.x}mm, #{f from.y}mm) -- (#{f to.x}mm, #{f to.y}mm);\n"
    end
    
    def label(coord, width, style, text)
      @output << "\\node [#{style}, text width = #{f width}mm] at (#{f coord.x}mm, #{f coord.y}mm) {#{escape_tex_special_chars text.to_s}};\n"
    end
    
    def bar(from, to, style)
      x_mid, width = to_tikz_coords(from.x, to.x)
      @output << "\\node [#{style}] at (#{f x_mid}mm, #{f from.y}mm) [minimum width = #{f width}mm] {};\n"
    end
    
    def newline
      @output << "\n"
    end
    
    def to_s # => String
      @output.string
    end
    
  private
  
    # f(1.2345) => "1.23"
    def f(number)
      '%.02f' % number
    end
    
    # escape_tex_special_chars("a#b&c|d") => "a\#b\&c\|d"
    def escape_tex_special_chars(text)
      text.gsub(/([#&|])/, '\\\\\\1')
    end
    
    # to_tikx_coords(x_from, x_to) => [ x_mid, width ]
    def to_tikz_coords(x_from, x_to)
      width = x_to - x_from
      x_mid = x_from + (width / 2.0)
      [x_mid, width]
    end
  
  end
end
