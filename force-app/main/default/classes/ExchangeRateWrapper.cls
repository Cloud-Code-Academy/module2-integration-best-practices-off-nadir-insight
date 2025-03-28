/**
 * @description Wrapper class to deserialize the JSON response from the Exchange Rate API
 * Students will implement the properties and methods to process the data
 */
public class ExchangeRateWrapper {
    
    // TODO: Implement properties to match the JSON structure of the API response
    // Sample response:
    // {
    //   "base_code": "USD",
    //   "time_last_update_unix": 1740690001,
    //   "conversion_rates": {
    //     "EUR": 0.9488,
    //     "GBP": 0.8393,
    //     "JPY": 136.57,
    //     ...
    //   }
    // }
    
    // Add properties for base currency
    public String base_code;
    
    // Add property for time last updated
    public String time_last_update_unix;
    
    // Add property for rates (using a map)
    public Map<String, Decimal> conversion_rates;

    // Add property for external ID
    // This is an ID you will generate to uniquely identify the exchange rate record
    // This does not come from the API response
    // public String externalId; baseCurrency + '_' + targetCurrency
    public String externalId;
    
    /**
     * @description Converts the wrapper data to a list of Exchange_Rate__c records
     * @return List<Exchange_Rate__c> The list of exchange rate records
     */
    public List<Exchange_Rate__c> toExchangeRates() {
        // TODO: Implement the method to convert the wrapper data to Exchange_Rate__c records
        // 1. Create a list to hold the Exchange_Rate__c records
        // 2. Iterate through the rates map
        // 3. For each rate, create an Exchange_Rate__c record
        // 4. Return the list of records

        if (this.conversion_rates == null || this.conversion_rates.isEmpty()) {
            return null;
        }

        List<Exchange_Rate__c> records = new List<Exchange_Rate__c>();
        for(String key : this.conversion_rates.keySet()) {
            Decimal converstion_rate = conversion_rates.get(key);
            Exchange_Rate__c record = new Exchange_Rate__c();
            record.Base_Currency__c = this.base_code;
            record.Rate__c = converstion_rate;
            record.Target_Currency__c = key;
            record.Last_Updated__c = System.now();
            record.External_id__c = this.base_code + '_' + key;
            records.add(record);
        }
        return records;
    }
    
    /**
     * @description Static method to parse the JSON response into the wrapper class
     * @param jsonResponse The JSON response from the API
     * @return ExchangeRateWrapper The parsed wrapper instance
     */
    public static ExchangeRateWrapper parse(String jsonResponse) {
        return (ExchangeRateWrapper) JSON.deserialize(jsonResponse, ExchangeRateWrapper.class);
    }
}