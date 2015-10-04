class Inventory
  def self.import(file_path)
    file = File.read(file_path)
    JSON.parse(file).each do |item|
      import_from_hash(item.deep_symbolize_keys)
    end
  end

  def self.clear
    Item.destroy_all
  end

  def self.most_expensive_books
    Book.order('price DESC')
      .limit(5)
      .to_a
  end

  def self.most_expensive_cds
    Cd.order('price DESC')
      .limit(5)
      .to_a
  end

  def self.most_expensive_dvds
    Dvd.order('price DESC')
      .limit(5)
      .to_a
  end

  def self.long_duration_cds
    Cd.joins(:tracks)
      .group(:id)
      .having('sum(tracks.seconds) > 60 * 60')
      .to_a
  end

  def self.authors_also_released_cds
    Cd.pluck(:author).uniq & Book.pluck(:author).uniq
  end

  def self.items_with_title_track_or_chapter_contains_year(year)
    ids_from_title = Item.where("title like '%#{year}%'").pluck(:id)
    ids_from_tracks = Track.where("name like '%#{year}%'").pluck(:item_id).uniq
    ids_from_chapters = Chapter.where("name like '%#{year}%'").pluck(:item_id).uniq

    ids = (ids_from_chapters + ids_from_tracks + ids_from_title).uniq

    Item.where(id: ids).to_a
  end

  private

  def self.import_from_hash(item)
    type = item.delete(:type)
    title = item.delete(:title)
    price = item.delete(:price)
    author = item.delete(:author) || item.delete(:director)
    year = item.delete(:year)

    if type == "book"
      chapters = item.delete(:chapters)
      book = Book.create(title: title,
                         price: price,
                         author: author,
                         year: year,
                         extra_info: item)

      chapters.each { |chapter| book.chapters.create(name: chapter) }

    elsif type == "cd"
      tracks = item.delete(:tracks)
      cd = Cd.create(title: title,
                     price: price,
                     author: author,
                     year: year,
                     extra_info: item)

      tracks.each { |track| cd.tracks.create(name: track[:name],
                                             seconds: track[:seconds]) }
    elsif type == "dvd"
      Dvd.create(title: title,
                 price: price,
                 author: author,
                 year: year,
                 extra_info: item)
    end
  end
end
