ActiveRecord::Schema.define do
  create_table(:authors) do |t|
    t.string :name
    t.references :company
  end
  create_table(:books) do |t|
    t.string :title
    t.string :type
    t.references :author
    t.references :publisher
  end
  create_table(:profiles) do |t|
    t.string :address
    t.references :author
  end
  create_table(:profile_histories) do |t|
    t.date :updated_on
    t.references :profile
  end
  create_table(:publishers) { |t| t.string :name }
  create_table(:movies) do |t|
    t.string :name
    t.references :author
  end
  create_table(:magazines) { |t| t.string :title }
  create_table(:authors_magazines) do |t|
    t.references :author
    t.references :magazine
  end
  create_table(:companies) { |t| t.string :name }
  create_table(:bookstores) { |t| t.string :name }
end
