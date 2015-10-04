# Installation

``` git clone https://github.com/bill-zhongjie-li/test.git ```

``` cd store ```

``` bundle ```

``` rake db:create ```

``` rake db:migrate ```

# Usage

Start Rails console: 

``` rails console ```

## Run under Rails console

To import to inventory from a file:

``` Inventory.import(file_path) ```

To clear inventory:

``` Inventory.clear ```

To get top five most expensive books:

``` Inventory.most_expensive_books ```

To get top five most expensive cds:

``` Inventory.most_expensive_cds ```

To get top five most expensive dvds:

``` Inventory.most_expensive_dvds ```
  
To get cds with total running time more than 60 minutes:

``` Inventory.long_duration_cds ```
  
To get book authors who also released cds:

``` Inventory.authors_also_released_cds ```
  
To get items which have title, track or chapter contains a specific year (say 2002):

``` Inventory.items_with_title_track_or_chapter_contains_year(2002) ```
