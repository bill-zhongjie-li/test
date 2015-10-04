require "rails_helper"

describe Inventory do
  describe ".most_expensive_books" do
    let!(:book_one) { create :book, price: 60 }
    let!(:book_two) { create :book, price: 50 }
    let!(:book_three) { create :book, price: 40 }
    let!(:book_four) { create :book, price: 30 }
    let!(:book_five) { create :book, price: 20 }
    let!(:book_six) { create :book, price: 10 }

    it "returns the top file most expensive books" do
      expect(Inventory.most_expensive_books.collect(&:id))
        .to eq [book_one, book_two, book_three, book_four, book_five].collect(&:id)
    end
  end

  describe ".most_expensive_cds" do
    let!(:cd_one) { create :cd, price: 60 }
    let!(:cd_two) { create :cd, price: 50 }
    let!(:cd_three) { create :cd, price: 40 }
    let!(:cd_four) { create :cd, price: 30 }
    let!(:cd_five) { create :cd, price: 20 }
    let!(:cd_six) { create :cd, price: 10 }

    it "returns the top file most expensive cds" do
      expect(Inventory.most_expensive_cds.collect(&:id))
        .to eq [cd_one, cd_two, cd_three, cd_four, cd_five].collect(&:id)
    end
  end

  describe ".most_expensive_dvds" do
    let!(:dvd_one) { create :dvd, price: 60 }
    let!(:dvd_two) { create :dvd, price: 50 }
    let!(:dvd_three) { create :dvd, price: 40 }
    let!(:dvd_four) { create :dvd, price: 30 }
    let!(:dvd_five) { create :dvd, price: 20 }
    let!(:dvd_six) { create :dvd, price: 10 }

    it "returns the top file most expensive dvds" do
      expect(Inventory.most_expensive_dvds.collect(&:id))
        .to eq [dvd_one, dvd_two, dvd_three, dvd_four, dvd_five].collect(&:id)
    end
  end

  describe ".long_duration_cds" do
    let(:cd_one) { create :cd }
    let(:cd_two) { create :cd }
    let(:track_one) { create :track, seconds: 2000 }
    let(:track_two) { create :track, seconds: 2000 }
    let(:track_three) { create :track, seconds: 2000 }

    before do
      cd_one.tracks << track_one
      cd_one.tracks << track_two
      cd_two.tracks << track_three
    end

    it "returns the cds with running time more than 60 minutes" do
      expect(Inventory.long_duration_cds.collect(&:id)).to eq [cd_one.id]
    end
  end

  describe ".authors_also_released_cds" do
    let!(:book_one) { create :book, author: "Bill Li" }
    let!(:book_two) { create :book, author: "Jim Li" }
    let!(:cd) { create :cd, author: "Bill Li"  }

    it "returns book authors who also released cds" do
      expect(Inventory.authors_also_released_cds).to eq ["Bill Li"]
    end
  end

  describe ".items_with_title_track_or_chapter_contains_year" do
    let!(:book_one) { create :book, title: "In the year 2002" }
    let!(:book_two) { create :book }
    let(:book_three) { create :book }
    let(:book_four) { create :book }

    let!(:cd_one) { create :cd, title: "In the year 2002" }
    let!(:cd_two) { create :cd }
    let(:cd_three) { create :cd }
    let(:cd_four) { create :cd }

    let!(:dvd_one) { create :dvd, title: "In the year 2002" }
    let!(:dvd_two) { create :dvd }

    let(:track_one) { create :track, name: "In the year 2002" }
    let(:track_two) { create :track }

    let(:chapter_one) { create :chapter, name: "In the year 2002" }
    let(:chapter_two) { create :chapter }

    before do
      book_three.chapters << chapter_one
      book_four.chapters << chapter_two

      cd_three.tracks << track_one
      cd_four.tracks << track_two
    end

    it "returns items with title, chapter or track cantains a year" do
      expect(Inventory.items_with_title_track_or_chapter_contains_year(2002).collect(&:id).sort)
        .to eq [book_one, book_three, cd_one, cd_three, dvd_one].collect(&:id).sort
    end
  end

  describe ".import_from_hash" do
    let(:data){[
      {
        "price": 15.99,
        "chapters": [
          "one",
          "two",
          "three"
        ],
        "year": 1999,
        "title": "foo",
        "author": "mary",
        "type": "book"
      },
      {
        "price": 11.99,
        "minutes": 90,
        "year": 2004,
        "title": "bar",
        "director": "alan",
        "type": "dvd"
      },
      {
        "price": 15.99,
        "tracks": [
          {
            "name": "one",
            "seconds": 180
          },
          {
            "name": "two",
            "seconds": 180
          }
        ],
        "year": 2000,
        "title": "baz",
        "author": "joan",
        "type": "cd"
      }
    ]}

    before do
      data.each { |item| Inventory.import_from_hash(item) }
    end

    specify { Item.count.should eq 3 }
  end
end
