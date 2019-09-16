require 'csv'

class Vote < ApplicationRecord

  def self.to_csv
    attributes = %w{cpf vote}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |vote|
        csv << attributes.map{ |attr| vote.send(attr) }
      end
    end
  end

  validates_inclusion_of :vote, :in => 0..2, :message => "Chapas válidas: 1 e 2 ou 0 (Branco)"
end
