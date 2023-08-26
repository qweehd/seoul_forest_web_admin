class RegionQueries {
  static const String getAllCountries = '''
      query MyQuery {
        listCountries {
          items {
            id
            flagEmoji
            dialCode
            currencyCode
            currency
            continentID
            createdAt
            code
            name
            updatedAt
            cities {
              items {
                createdAt
                hasMainCategories
                id
                imageKey
                latitude
                longitude
                name
                serviceOpeningDate
                state
                updatedAt
                zoneID
                zoomLevel
              }
            }
          }
        }
      } 
 ''';
}
