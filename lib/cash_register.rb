class CashRegister
    attr_accessor :total, :discount, :items, :last_transaction
    def initialize(discount=0)
        @total = 0
        @discount = discount
        @items = {}
        @last_transaction = {}
    end
    def add_item(name, price, quantity=1)
        item = {
            price: price,
            quantity: quantity
        }
        @total += price * quantity
        @items.store(name, item)
        @last_transaction = {name => item}
    end

    def apply_discount
        if @discount != 0
            @total -= Float(@total) * (@discount / 100.0)
            "After the discount, the total comes to $#{Integer(@total)}."
        else
            "There is no discount to apply."
        end
    end

    def items
        items_keys = @items.keys
        items_array = []
        i = 0
        while i < @items.keys.length
            if @items[items_keys[i]][:quantity] != 1
                j = 0
                while j < @items[items_keys[i]][:quantity]
                    items_array.push(items_keys[i])
                    j = j+1
                end
            else
                items_array.push(items_keys[i])
            end
            i= i+1
        end
        items_array
    end

    def void_last_transaction
        @items.delete(@last_transaction.keys[0])
        total_item_removed =  @last_transaction[@last_transaction.keys[0]][:price] * @last_transaction[@last_transaction.keys[0]][:quantity]
        @total = @total - total_item_removed
        if(@items.length == 0)
            @total = 0
        end
    end


end
new_cash = CashRegister.new(50)
new_cash.add_item("eggs", 1.99)
new_cash.add_item("tomato", 1.76, 2)
new_cash.items
pp new_cash.void_last_transaction
