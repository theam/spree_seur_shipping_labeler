Spree::Address.class_eval do
    def seur_formatted(email, instructions)
            {
              name:          full_name,
              email:         email,
              company:       company,
              phone_number:  phone,
              address:       [address1, address2, street_number, street_key, entrance, city].compact.join(' '),
              city:          city,
              state:         state,
              zip_code:       zipcode,
              country_iso:   country.iso,
              instructions:  instructions
            }
    end
end