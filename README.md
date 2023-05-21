# Ruby Vending Machine 🎰

## Requirements
* Ruby 2.7.5

## Setup

1. Clone this repo
2. Install gems
```
bundle install
```
3. Run
```
ruby main.rb
```
and follow instructions!

3. Run tests
```
rspec spec
```

## Example of usage

```
➜  vending_machine ruby main.rb

########################################
#                                      #
#   Welcome to Ruby Vending Machine!   #
#                                      #
########################################

Select action:
1. Check vm info
2. Buy product
Exit by default
> 
```

Type `1` to see vm information

```
> 1

List of available products
+----+--------------+-------+-------+
| id | name         | price | count |
+----+--------------+-------+-------+
| 1  | Coca Cola    | 2.0   | 10    |
| 2  | Sprite       | 2.5   | 10    |
| 3  | Fanta        | 2.25  | 10    |
| 4  | Orange Juice | 3.0   | 10    |
| 5  | Water        | 3.25  | 0     |
+----+--------------+-------+-------+

List of available coins
+-------+-------+
| value | count |
+-------+-------+
| 5     | 5     |
| 3     | 5     |
| 2     | 5     |
| 1     | 5     |
| 0.5   | 5     |
| 0.25  | 5     |
+-------+-------+

VM balance
+-----------------+-------+
| machine balance | 58.75 |
+-----------------+-------+
```

Type `2` to buy some product

```
> 2
Select a product (id): 2

Selected: Sprite
Enter amount to insert: 13

Change info
+---------------+-------------+
| Change amount | Coins value |
+---------------+-------------+
| 10.5          | 5, 5, 0.5   |
+---------------+-------------+
```

Type any other character to exit.