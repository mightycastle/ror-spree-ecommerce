module Nelou
  module Variant
    module LimitedItems
      extend ActiveSupport::Concern

      included do
        validates :limited_items, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
        validates :limited_items_sold, numericality: { only_integer: true, lesser_than_or_equal_to: :limited_items }, allow_nil: true
        validates :limited_items, presence: true, if: :limited?
      end

      def limited?
        limited
      end

      def limited_items_available
        if limited_items.nil? || limited_items_sold > limited_items
          0
        else
          limited_items - limited_items_sold
        end
      end

      def can_supply?
        !limited? || (limited_items_sold <= limited_items)
      end

      def set_limited
        limited = true
      end
    end
  end
end