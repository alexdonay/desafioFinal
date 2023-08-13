class Upload < ApplicationRecord
    # Configurações para o Active Storage, se necessário
    has_one_attached :file
  end