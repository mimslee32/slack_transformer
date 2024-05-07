module SlackTransformer
  class Html
    class Hyperlinks
      attr_reader :input

      def initialize(input)
        @input = input
      end

      def to_slack
        fragment = Nokogiri::HTML.fragment(input)

        fragment.children.each do |child|
          if child.name == 'a'
            hyperlink_text = child.text || child.attr('href')
            hyperlink = "<#{child.attr('href')}|#{hyperlink_text}>"
            input = input.gsub(child.to_s, hyperlink)
          end
        end
      end
    end
  end
end
